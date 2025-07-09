/* eslint-disable @typescript-eslint/no-type-alias */

  interface NestedValidator<T> {
    [key: string]: T;
  }

  type Validator =
    | ValidatorMapFunc
    | ValidatorMapFunc[]
    | ValidatorAction
    | NestedValidator<Validator>;

  interface ValidatorMap {
    [s: string]: Validator;
  }

  export default function lookupValidator(
    validationMap: ValidatorMap
  ): (params: {
    key: string;
    newValue: unknown;
    oldValue: unknown;
    changes: { [s: string]: unknown };
    content: { [s: string]: unknown };
  }) => string | boolean | [boolean] | string[] | Promise<ValidationResult>;
}
