Return-Path: <linux-edac+bounces-2763-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 728C09FEDEA
	for <lists+linux-edac@lfdr.de>; Tue, 31 Dec 2024 09:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DEEC162328
	for <lists+linux-edac@lfdr.de>; Tue, 31 Dec 2024 08:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF2218B470;
	Tue, 31 Dec 2024 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehvLhzXk"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFF97346D;
	Tue, 31 Dec 2024 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735633196; cv=none; b=C4TgaNhcgO58qRIGKQg5O2ej9n4IBERKNjqoHgrOmIzMKgQrf8isdHuRrJAXXFA+H9JsT7ybQHItDXyvlUwy7c45wYP0kbwXgvucUKp683e25q/VelmGj0EcPJuS3/BcnVRmTKq6G1nLQmhV/x1Pm8UWfBGa3YWpV7sHxx87SUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735633196; c=relaxed/simple;
	bh=6K1BMxyOBliBcOsmWorNVGeQWa7ND39bDJMSJZnkw7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stX6qRl/81SRdTluZ35AEPAxx3c5R0e1c7La0CZsMaSfG6NLPV8wShpxIITlMFuzNpG6j47RzYvRg3OoIjr5B+w5K6Pn2nYc6umg8IlVreReQsdkNyhs33P6V7frbW9WZTLKoTQSfZ3I7ssxZeE9JJUQC6Y0n8k72H8ejygzWcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehvLhzXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F234EC4CED6;
	Tue, 31 Dec 2024 08:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735633195;
	bh=6K1BMxyOBliBcOsmWorNVGeQWa7ND39bDJMSJZnkw7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ehvLhzXk3EX0HgJDM7aqT3k32ZyiiLKWL3O1CGbSGoX7JfrnTcLfIu23gtxd5PftJ
	 LYkmxkxtRtG4TR/pYO13ZuwGtrYB2bRLKr9ULUaIGnQzzkVTELCqhhcmO/Um7Fg6JO
	 1h0bjtptrgn9HO7B8jU/30tVbKwfnYb8E50mrZnL2bwV1Z73TN+PsLOSoA5aD62KpA
	 vMqB/789Krc3o1YC4fOmRqc96ulxaDH9I1b5p393CONyxShEhtG7SrwR5oEy7TkY/B
	 ffgIjRBS1YTBN0ZTZyAee4gPq194S8lNgQszi28N7hGPWIvJfWBA4IQ0Ym+bYKlmrT
	 kThflFQBg/ZBA==
Date: Tue, 31 Dec 2024 09:19:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	James Morse <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Robert Richter <rric@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-edac@vger.kernel.org, git@amd.com
Subject: Re: [PATCH v3 4/5] dt-bindings: memory-controllers: Add support for
 Versal NET EDAC
Message-ID: <43dp3ifjol3zjei6zs55tgsdbfmdwnihnjwnuhak7sssrmztoz@3bna4b7hclcu>
References: <20241231063434.26998-1-shubhrajyoti.datta@amd.com>
 <20241231063434.26998-5-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241231063434.26998-5-shubhrajyoti.datta@amd.com>

On Tue, Dec 31, 2024 at 12:04:33PM +0530, Shubhrajyoti Datta wrote:
> Add device tree bindings for AMD Versal NET EDAC for DDR controller.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - rename EDAC to memory controller
> - update the compatible name
> - Add remote proc handle
> - Read the data width from the registers
> - Remove the dwidth, rank and channel number the same is read from the RpMsg.
> 
>  .../amd,versalnet-ddrmc.yaml                  | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/amd,versalnet-ddrmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/amd,versalnet-ddrmc.yaml b/Documentation/devicetree/bindings/memory-controllers/amd,versalnet-ddrmc.yaml
> new file mode 100644
> index 000000000000..b6fc3548017d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/amd,versalnet-ddrmc.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/amd,versalnet-ddrmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Versal NET Memory Controller
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
> +    const: amd,versalnet-ddrmc

Not much improved.

> +
> +  amd,rproc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to the remoteproc_r5 rproc node using which APU interacts
> +      with remote processor.


So no description of memory? I am fine with it, but then note that
bindings are supposed to be complete, so don't come later with missing
pieces.

> +
> +required:
> +  - compatible
> +  - amd,rproc
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    memory-controller {
> +       compatible = "amd,versalnet-ddrmc";
> +       amd,rproc = <&remoteproc_r5>;
> +     };

Misaligned.

Best regards,
Krzysztof


