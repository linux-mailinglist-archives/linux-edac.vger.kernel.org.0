Return-Path: <linux-edac+bounces-5246-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C08ABC18867
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 07:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33AE74E3107
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 06:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86F82FD7A0;
	Wed, 29 Oct 2025 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STqMkBxR"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AAA33993;
	Wed, 29 Oct 2025 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761720691; cv=none; b=rFCHSVsKoxcaENK8u5FT1aiLMW0Wp+L8Y68N1s+CwG+NBkl47/oLRs66SzgfjqN+aCckn5A01SJQ7TVdLc2X45gFyzWxKxPI9jalWK0V12a+TcywwlCcjVPAyL+nmGk3tCb9rwgPwZECNr4CYoF46/nMeUYzxxG0K4a9wa6PoaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761720691; c=relaxed/simple;
	bh=yosfg9zWw754GTbw2UMgMVfc3t8Ka+fE8ls52tjzkPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpLLqAHZhIgaVZIMrNvqCPYttQK2dG0IiDLyTUc7fjxAJxsZuPQoHpIAQ0cEB+QYWpqclLRHgER2d8i0zwhFstV7Ozwy0F1DASJqdxV090wP9U0YB1gyiaSs69rKZxs/3NgtnWX6t7AFmX0nHwKm8PkD4nxnNP/KtvdSg7dodE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STqMkBxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E39C4CEF7;
	Wed, 29 Oct 2025 06:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761720691;
	bh=yosfg9zWw754GTbw2UMgMVfc3t8Ka+fE8ls52tjzkPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=STqMkBxRAyeb77j4Bcw5zul7GrQ1wJ8svWRBDtq2taWOtdRWVaS0H3TJQJTwcU9zI
	 I62LzINOf123cWqTl7laOHSXpduZ8iyOssZ6qwg/b3n+ESX5ZyAJt4gljmCzeagCSN
	 VDvH9wh9suzqawYrTOdGsHyGsw5VeWRnc0IDBTliGWtZU10jocKJX5hg9RChDRgX2O
	 o4a2nLBJFeInm/RQogzTUDvOmglimZQHOk+CA6qj2r5whPRIDuhXMWxrQgAEb/RhJp
	 PKkT1wxuuCY5h2YCY/gvNpasgUpDbk6EOpVdlqO+f7wlWDX6Xibp/79dlWsh6k8KiD
	 IvTTfRLQPBrhw==
Date: Wed, 29 Oct 2025 07:51:28 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: niravkumarlaxmidas.rabara@altera.com
Cc: dinguyen@kernel.org, matthew.gerlach@altera.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, bp@alien8.de, tony.luck@intel.com, 
	linux-edac@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] arm64: dts: agilex5: Add ECC manager and submodule
 nodes
Message-ID: <20251029-devout-wise-toad-8b36ed@kuoka>
References: <20251028092232.773991-1-niravkumarlaxmidas.rabara@altera.com>
 <20251028092232.773991-3-niravkumarlaxmidas.rabara@altera.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028092232.773991-3-niravkumarlaxmidas.rabara@altera.com>

On Tue, Oct 28, 2025 at 05:22:28PM +0800, niravkumarlaxmidas.rabara@altera.com wrote:
> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> 
> Add the ECC manager (eccmgr) node and its associated ECC submodules to the
> Agilex5 SoCFPGA device tree. The eccmgr node serves as a logical parent to
> group various ECC hardware instances, including those for USB, Ethernet,
> OCRAM, IO96B memory controllers, Secure Device Manager (SDM) QSPI, and
> Configuration RAM (CRAM) Single Event Upset (SEU) subsystems.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> ---
>  .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)

DTS cannot be the second patch. Organize your patchset correctly, see
submitting patches.


> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> index 04e99cd7e74b..5ea7a506d3d2 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> @@ -428,6 +428,104 @@ usb0: usb@10b00000 {
>  			status = "disabled";
>  		};
>  
> +		eccmgr {
> +			compatible = "altr,socfpga-a10-ecc-manager";
> +			altr,sysmgr-syscon = <&sysmgr>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 95 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 120 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "global_sbe", "global_dbe", "io96b0" , "io96b1",
> +					  "sdm_qspi_sbe", "sdm_qspi_dbe", "sdm_seu";
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			ranges;
> +
> +			ocram-ecc@108cc000 {
> +				compatible = "altr,socfpga-a10-ocram-ecc";
> +				reg = <0x108cc000 0x100>;
> +				interrupts = <1 IRQ_TYPE_LEVEL_HIGH>, <33 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			usb0-ecc@108c4000 {
> +				compatible = "altr,socfpga-usb-ecc";
> +				reg = <0x108c4000 0x100>;
> +				altr,ecc-parent = <&usb0>;
> +				interrupts = <2 IRQ_TYPE_LEVEL_HIGH>, <34 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			emac0-rx-ecc@108c0000 {
> +				compatible = "altr,socfpga-eth-mac-ecc";
> +				reg = <0x108c0000 0x100>;
> +				altr,ecc-parent = <&gmac0>;
> +				interrupts = <4 IRQ_TYPE_LEVEL_HIGH>, <38 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			emac0-tx-ecc@108c0400 {
> +				compatible = "altr,socfpga-eth-mac-ecc";
> +				reg = <0x108c0400 0x100>;
> +				altr,ecc-parent = <&gmac0>;
> +				interrupts = <5 IRQ_TYPE_LEVEL_HIGH>, <37 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			emac1-rx-ecc@108c0800 {
> +				compatible = "altr,socfpga-eth-mac-ecc";
> +				reg = <0x108c0800 0x100>;
> +				altr,ecc-parent = <&gmac1>;
> +				interrupts = <6 IRQ_TYPE_LEVEL_HIGH>, <38 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			emac1-tx-ecc@108c0c00 {
> +				compatible = "altr,socfpga-eth-mac-ecc";
> +				reg = <0x108c0c00 0x100>;
> +				altr,ecc-parent = <&gmac1>;
> +				interrupts = <7 IRQ_TYPE_LEVEL_HIGH>, <39 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			emac2-rx-ecc@108c1000 {
> +				compatible = "altr,socfpga-eth-mac-ecc";
> +				reg = <0x108c1000 0x100>;
> +				altr,ecc-parent = <&gmac2>;
> +				interrupts = <8 IRQ_TYPE_LEVEL_HIGH>, <40 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			emac2-tx-ecc@108c1400 {
> +				compatible = "altr,socfpga-eth-mac-ecc";
> +				reg = <0x108c1400 0x100>;
> +				altr,ecc-parent = <&gmac2>;
> +				interrupts = <9 IRQ_TYPE_LEVEL_HIGH>, <41 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			io96b0-ecc@18400000 {
> +				compatible = "altr,socfpga-io96b0-ecc";
> +				reg = <0x18400000 0x1000>;

Could not express more: NAK. Completely pointless node with pointless
name.

Best regards,
Krzysztof


