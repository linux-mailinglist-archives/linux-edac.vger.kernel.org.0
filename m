Return-Path: <linux-edac+bounces-2628-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D369D6A48
	for <lists+linux-edac@lfdr.de>; Sat, 23 Nov 2024 17:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B8A16180F
	for <lists+linux-edac@lfdr.de>; Sat, 23 Nov 2024 16:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4A1139D1B;
	Sat, 23 Nov 2024 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlnFaSdW"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24B217C2;
	Sat, 23 Nov 2024 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732380289; cv=none; b=LIRS1Hl6tRoMHaiuHqst3JRRUSz5qPTq2O+PivDKOVm0//y+NRzAtWAvsv51EnogaiYJdiXvQzZHXXq9nGEZL9noE3hIM/1EyWOzZH0FkaxptQALNm/TSgOpbqtkt4afuzpkRdlS9MonklCMxM3FdGj05aq7iNyRnRXnxvd0Ds8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732380289; c=relaxed/simple;
	bh=CxtPnF3g926VPClgLAxkiaL7rxCiMryhQt3b8SJmi2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkY60ZHUWlnpv8XI6P1Ui8IAumgL5EAg7FhaAZwGsL/x3yxSgYUy3UBQ0QZgRcxRb4FTcBkI+FwjjAnWFFbcRu0XdqmVJqp0NfFxNdbdojdorLNxyU5nLdc0HXEwWz05SsqfuByHpG4wM/WJpe171fn7Azb31PdN+GzCxxfoV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlnFaSdW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80159C4CECD;
	Sat, 23 Nov 2024 16:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732380289;
	bh=CxtPnF3g926VPClgLAxkiaL7rxCiMryhQt3b8SJmi2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dlnFaSdW9JEjxAwPAHJUCJupCTXHpTwt+B9+fbki0tvkwRDIb6SEmEQMa8JNJJydi
	 7Yk4VXWO5qB5vRtoFZ23oFkGh1AFlsjguuzQkLB3EkcEKyu0bBVcRwyXMwgROPmdlA
	 6H5qPyTRumTU2N5w4tqtJ9pLVztxm3KVcCeFjSSzrlbipBfUFGO9ipneYz0fOfyOI7
	 wnREmduLaTxFn4gYPsUTBYN+P9Y5ilULTKZG5v+M02D/rexdgCn7izahmpfnC5xatA
	 ZfbYmTQCI3eF3E+H/SVMaxwyXs0GbKmZLWks9DmCQI3jjU8qyIKgR4iR0O90LSAnNM
	 M5i3G/sn6qGWg==
Date: Sat, 23 Nov 2024 17:44:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-edac@vger.kernel.org, git@amd.com, krzk@kernel.or, robh@kernel.org, 
	conor+dt@kernel.org, bp@alien8.de, tony.luck@intel.com, james.morse@arm.com, 
	mchehab@kernel.org, rric@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: memory-controllers: Add support for
 Versal NET EDAC
Message-ID: <uw5yvotdr4u5uau7bqjj2qdmkf5ay2bm7km3zhqunbixzljlw6@wi6cujvdhesk>
References: <20241122100625.24571-1-shubhrajyoti.datta@amd.com>
 <20241122100625.24571-2-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122100625.24571-2-shubhrajyoti.datta@amd.com>

On Fri, Nov 22, 2024 at 03:36:23PM +0530, Shubhrajyoti Datta wrote:
> Add device tree bindings for AMD Versal NET EDAC for DDR controller.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 

Use tools to create cc-list, like b4 or:
https://github.com/krzk/tools/blob/master/linux/.bash_aliases_linux#L92
so you won't make a typo in my email.

>  .../amd,versalnet-edac.yaml                   | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/amd,versalnet-edac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/amd,versalnet-edac.yaml b/Documentation/devicetree/bindings/memory-controllers/amd,versalnet-edac.yaml
> new file mode 100644
> index 000000000000..22a4669c46b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/amd,versalnet-edac.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/amd,versalnet-edac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMD Versal NET EDAC

s/EDAC/Memory Controller
or something similar, I guess.

> +
> +maintainers:
> +  - Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> +
> +description:
> +  The integrated DDR Memory Controllers (DDRMCs) support both DDR4 and LPDDR4/
> +  4X memory interfaces. Versal NET DDR memory controller has an optional ECC support
> +  which correct single bit ECC errors and detect double bit ECC errors.
> +  It also has support for reporting other errors like MMCM (Mixed-Mode Clock
> +  Manager) errors and General software errors.
> +
> +properties:
> +  compatible:
> +    const: amd,versalnet-edac

Why using different name than all others? Keep consistent stuff for
your SoCs.

Also, s/edac/memory-controller/, depending what this stuff really is.

> +
> +  amd,dwidth:
> +    description:
> +      DDR memory controller device width.

Use existing properties.


> +    enum: [16, 32]
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  amd,num-chans:
> +    description:
> +      Number of channels.

Use existing properties, e.g. some of the DDR schemas describing memory.
Look how other bindings describe actual chips.

> +    enum: [1, 2]
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  amd,num-rank:
> +    description:
> +      Number of rank.
> +    enum: [1, 2, 4]
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible

Eh, no resources? How do you talk with the hardware? This looks way too
Linuxy...

Best regards,
Krzysztof


