Return-Path: <linux-edac+bounces-2771-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3BE9FFE04
	for <lists+linux-edac@lfdr.de>; Thu,  2 Jan 2025 19:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6883A0412
	for <lists+linux-edac@lfdr.de>; Thu,  2 Jan 2025 18:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD30F18FC89;
	Thu,  2 Jan 2025 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3wndOJu"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D5315539D;
	Thu,  2 Jan 2025 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735842203; cv=none; b=n9OFQx6LfLVJdCsI+/59vpVxrM+WDt7I/C7oyQFLMaHkmIUF0AIjniuOKVmnAA6bGcMRsL4B/TD9XEQH6gUyTZWY5kBl7GgNzFti+bOm0gNPkbEBODOxOKIgbOhrorNJdMsSSd2E5vs9XfFSG726yyeVjKKxJBEnc22Vnz7XYEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735842203; c=relaxed/simple;
	bh=70hV7KT0NdzyraKVXwtB6C/LT+wCto+7q8AHFbaR56c=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=npWHOuV1tpMY2c+R4+4rKQC9VyUZK5e15NXTabpcBNtuMnvcwktT5mZBh0xYD9gtr0sg0wQ9D8cOHd4ibZoOIQQkVxUJ4HkFRBAvWdDf1Hnzxx1SQhaHkwJbI3CJXQqUNW6MeFITbfobNhGs9AefcXyoxzDmPofXQhBn5PCftlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3wndOJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFBDC4CED0;
	Thu,  2 Jan 2025 18:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735842202;
	bh=70hV7KT0NdzyraKVXwtB6C/LT+wCto+7q8AHFbaR56c=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=b3wndOJuzzy6v39Q1NcxMxCWyBKNt60QiDw5kkS2qIiJWtu7x3qvIdUOPxzWs0FAs
	 ZpyL0hSB3DE+vjEa4AtQOxe61EHqtFpFSwD9vi/NBssJAScN0OuFwD4hcKNSrJKcnc
	 RnlCryPiKbhSKjm4YMKmFgNJjU6CRtLM+zfm/7TcROcoep/oF2s9SwekitM+rCwtqA
	 JvXNg2cmnObp6GvQlYnFn69T6BPTudsm8RoT43d3KDCA0szSIkuw57/viEpvXmaXWp
	 9i2uw/bQdW5c04lqfGlzBIG6zsVrhmgSW+TR0W80qgwKi5rSOF33ZRGMD4XT/jtfEY
	 2WSriiPNmGeZQ==
Date: Thu, 02 Jan 2025 12:23:20 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Tony Luck <tony.luck@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, James Morse <james.morse@arm.com>, 
 linux-edac@vger.kernel.org, Robert Richter <rric@kernel.org>, git@amd.com, 
 Borislav Petkov <bp@alien8.de>, Conor Dooley <conor+dt@kernel.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
In-Reply-To: <20250102174434.17677-5-shubhrajyoti.datta@amd.com>
References: <20250102174434.17677-1-shubhrajyoti.datta@amd.com>
 <20250102174434.17677-5-shubhrajyoti.datta@amd.com>
Message-Id: <173584220090.229516.17125117813581030159.robh@kernel.org>
Subject: Re: [PATCH v4 4/5] dt-bindings: memory-controllers: Add support
 for Versal NET EDAC


On Thu, 02 Jan 2025 23:14:33 +0530, Shubhrajyoti Datta wrote:
> Add device tree bindings for AMD Versal NET EDAC for DDR controller.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
> Changes in v4:
> Update the compatible
> align the example
> Enhance the description for rproc
> 
> Changes in v2:
> - rename EDAC to memory controller
> - update the compatible name
> - Add remote proc handle
> - Read the data width from the registers
> - Remove the dwidth, rank and channel number the same is read from the RpMsg.
> 
>  .../amd,versal-net-ddrmc5-1.0.yaml            | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/amd,versal-net-ddrmc5-1.0.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/memory-controllers/amd,versal-net-ddrmc5-1.0.example.dtb: /example-0/memory-controller: failed to match any schema with compatible: ['amd,versalnet-ddrmc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250102174434.17677-5-shubhrajyoti.datta@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


