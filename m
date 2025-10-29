Return-Path: <linux-edac+bounces-5245-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3478BC18843
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 07:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE203BA34C
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 06:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330E42EC54D;
	Wed, 29 Oct 2025 06:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jime9CZc"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057BE126BF7;
	Wed, 29 Oct 2025 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761720608; cv=none; b=Yv3zPEAkASEqp5Wr+znLQd91SUdLQjiKbcytvRw+mS7C25AcK47YXTeoYFoLPkhcqHoy+BuXoKjC/X2xy0jS92sGZtHoyeeL2IZzJb4cwghMvL21uUx1blm66qR/iNgJdibjifTExMtEJiAsq0b2FYO6AKiA744tTTNFcwJJHGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761720608; c=relaxed/simple;
	bh=pDZtqhJqbNm3YHN3m6FTOaaPVV/5peqyF+hfo4Jai0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSG7f8fB+Huo+dHl0TBK7GOguxfQDPBUlnzxnQc1xYKrqu28Hnk0K/mBdrX9hOapxpmJbhJDy0TDq6FXsojMo6rwwVY9Rag3gWM6okx/Cx1NCCgEhjYtMCzv1dSm+G9i5g0T6gwTcMiDZSSMDXnUt/h0uDpoGSJ3t7BQ/2oNlIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jime9CZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C061C4CEF7;
	Wed, 29 Oct 2025 06:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761720604;
	bh=pDZtqhJqbNm3YHN3m6FTOaaPVV/5peqyF+hfo4Jai0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jime9CZcLYEA7ozWWX61TTZiJO/5IPMeaWoGslgh2zO6357fnVXasks5EcqdUYJIR
	 UC5m5gvmA3Ay5s/wllYA+8Mok/N6UIsp8a9Qs0YC5Q5BYCbXGKG0cyMsVfJsaeeB3o
	 vju37Jl32uuUi48+nq+hudouCbgEBuJbYT3XXoaKZsTfd9jyqmvK+h3a8ii9i8sCBQ
	 t46mnwAjtUEBVfdxHyEKkUI9/iYRBlp/EGCI9XO9xsyPAhxu9l4DwxEf+1MNALANQc
	 5NTU328rKWxDZ5GEHXZ3WDHKM7WSgxDw3iz8j0W61fhgqVakNB8pd/2MPTkx/kE2Of
	 uKLtiWZpexTYw==
Date: Wed, 29 Oct 2025 07:50:02 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: niravkumarlaxmidas.rabara@altera.com
Cc: dinguyen@kernel.org, matthew.gerlach@altera.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, bp@alien8.de, tony.luck@intel.com, 
	linux-edac@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: edac: altera: Document additional ECC
 instances
Message-ID: <20251029-adventurous-russet-jackal-64e3e5@kuoka>
References: <20251028092232.773991-1-niravkumarlaxmidas.rabara@altera.com>
 <20251028092232.773991-2-niravkumarlaxmidas.rabara@altera.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028092232.773991-2-niravkumarlaxmidas.rabara@altera.com>

On Tue, Oct 28, 2025 at 05:22:27PM +0800, niravkumarlaxmidas.rabara@altera.com wrote:
> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> 
> Add support for Secure Device Manager(SDM) QSPI ECC, IO96B memory
> controller ECC and Configuration RAM(CRAM) Single Event Upset(SEU).
> 
> Add interrupt-names property and increase interrupts maxItems from 2 to 7
> to accommodate additional interrupts.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> ---
>  .../edac/altr,socfpga-ecc-manager.yaml        | 77 ++++++++++++++++++-
>  1 file changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml b/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
> index 3d787dea0f14..5e0c08a15ab9 100644
> --- a/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
> +++ b/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
> @@ -33,7 +33,13 @@ properties:
>  
>    interrupts:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 7

No, list the interrupts instead. Your commit msg must clearly explain
why exception of not-fixed length/entries is justified.

See writing bindings.

> +
> +  interrupt-names:
> +    items:
> +      enum: [global_sbe, global_dbe, io96b0, io96b1, sdm_qspi_sbe, sdm_qspi_dbe, sdm_seu]

Nope, list the items instead. Please do not come up with some custom
syntax.

> +    minItems: 1
> +    maxItems: 7
>  
>    interrupt-controller: true
>  
> @@ -70,6 +76,41 @@ properties:
>        - interrupts
>        - altr,sdr-syscon
>  
> +  cram-seu:

Missing description, so difficult to say what is here.
Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
If you cannot find a name matching your device, please check in kernel
sources for similar cases or you can grow the spec (via pull request to
DT spec repo).

> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        items:
> +          - const: altr,socfpga-cram-seu

Why do you need compatible?

> +
> +      reg:
> +        maxItems: 1

So you created child node only for reg? No, fold it into parent.

You also forgot to update the example.

> +
> +      altr,seu-safe-inject-ce-msb:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: MSB of error injection command for Correctable Error
> +
> +      altr,seu-safe-inject-ce-lsb:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: LSB of error injection command for Correctable Error
> +
> +      altr,seu-safe-inject-ue-msb:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: MSB of error injection command for Uncorrectable Error
> +
> +      altr,seu-safe-inject-ue-lsb:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: LSB of error injection command for Uncorrectable Error

How are these board-level properties?

> +
> +    required:
> +      - compatible
> +      - altr,seu-safe-inject-ce-msb
> +      - altr,seu-safe-inject-ce-lsb
> +      - altr,seu-safe-inject-ue-msb
> +      - altr,seu-safe-inject-ue-lsb
> +
>  patternProperties:
>    "^ocram-ecc@[a-f0-9]+$":
>      type: object
> @@ -191,6 +232,40 @@ patternProperties:
>        - interrupts
>        - altr,ecc-parent
>  
> +  "^sdm-qspi-ecc@[a-f0-9]+$":
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        items:
> +          - const: altr,socfpga-sdm-qspi-ecc

No, drop.

> +
> +      reg:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - reg

No point for empty children. One reg is not justification for having a
child.

> +
> +  "^io96b[0-9]-ecc@[a-f0-9]+$":

You need to stop coming with random node names. Nothing explains why you
need children, why these are not part of parent node.

> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        items:
> +          - enum:
> +              - altr,socfpga-io96b0-ecc
> +              - altr,socfpga-io96b1-ecc

Plus all your compatibles have WRONG format. See writing bindings and
numerouse presentations - you always must use SoC specific compatible.

Best regards,
Krzysztof


