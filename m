Return-Path: <linux-edac+bounces-3388-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED03A6AD17
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 19:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73551468269
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 18:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BDA227E92;
	Thu, 20 Mar 2025 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keaOJIfz"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85897227E84;
	Thu, 20 Mar 2025 18:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742495177; cv=none; b=fRWXVcVyMbVzia0S9KJ1aF1YOli+yJxaFWQcnDdG77Sw8LN7KfrTPHTpn4eWE1aK3fiFLus5UlY7EFMQIcM176JWgwpu1C2JnRblT6zgqWyQD0jlJWWI2rNny9RVUO5nM1+r6h0NxnlYylDB+e8VPp/vW413S1b7JaRUiYWIftI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742495177; c=relaxed/simple;
	bh=OHKfwzcz+s+q8CWBXRZj/LDLztX6IWx6WyVwfoEPLIA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=vAyU8QTFC2PuU0+R0Mji4UoN5SDcWvpIczk0uPsNcTEQZJvf3CnF4lN3Wjm0QyHDOOMe9eGCMo3so3ezSD8xcdsOjrYk+4zmAORQLzQvQ75+Pp8LHzi1z5s3bfzgb8yZ0iDnQ91RqcQos038Y+tr6VW5XdWI/lQnyslrb8uRWHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keaOJIfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1DEC4CEE7;
	Thu, 20 Mar 2025 18:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742495176;
	bh=OHKfwzcz+s+q8CWBXRZj/LDLztX6IWx6WyVwfoEPLIA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=keaOJIfzidOPyCNC1Uu4YTM76RrUlFuCxr0NoTcLfhNAt0CO7UURElkViQYRT+joQ
	 +n4agJ1DGv3B4ISEGu7uVprvyxgJvw2Crv2iz16/PSN1y/J09KOwnUgi5XHP1zpNkW
	 ct/LOSGrBx4feOJncEDGdd9RI7CbjUFd7FbwDJaIIokkZGKaO5VGTodp3n11nagRtF
	 cc3JM8lWCMFuv0ygO76sTCe4PjOjxP7OvclCU333EgD/HXoF3zsHYuUDaYMiycV5t8
	 Pt+WsmHPEgXBHD4NAFngf9Wy65aofAHXrBuQa8Jvh3NQ4d1H9tum+c2EtbJafgm8D/
	 fiwxe5UKtLJQw==
Date: Thu, 20 Mar 2025 13:26:14 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: mchehab@kernel.org, linux-edac@vger.kernel.org, tony.luck@intel.com, 
 conor+dt@kernel.org, krzk+dt@kernel.org, linux-kernel@vger.kernel.org, 
 james.morse@arm.com, rric@kernel.org, dinguyen@kernel.org, bp@alien8.de, 
 devicetree@vger.kernel.org
To: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <20250320164622.6971-1-matthew.gerlach@altera.com>
References: <20250320164622.6971-1-matthew.gerlach@altera.com>
Message-Id: <174249492093.658105.12153092759643432322.robh@kernel.org>
Subject: Re: [PATCH 0/4] dt-bindings: edac: altera-s10: Convert to YAML


On Thu, 20 Mar 2025 09:46:18 -0700, Matthew Gerlach wrote:
> This patch set creates a YAML device tree binding for the Altera Stratix10
> Error Detection and Correction component referred to as the ECC Manager. The
> peripheral subcomponents are the same hardware as the Arria10 implementation;
> so the YAML binding does not change compatible strings of the subcomponents.
> This more accurate hardware description requires some minor driver and DTSI/DTS
> changes.
> 
> Patch 1:
>   Convert text device tree binding to YAML.
> 
> Patch 2:
>   Update driver to allow the peripheral subcomponents to be child nodes of
>   altr,socfpga-s10-ecc-manager.
> 
> Patch 3:
>   Update Agilex DTSI to use correct compatible strings for peripheral
>   subcomponents.
> 
> Patch 4:
>   Update Stratix10 DTSI/DTS to use correct compatibles strings.
> 
> Matthew Gerlach (4):
>   dt-bindings: edac: altera-s10: Convert to YAML
>   EDAC, altera: update driver to reflect hw/yaml
>   arm64: dts: agilex: Update eccmgr in DTSI to reflect hw/yaml
>   arm64: dts: startix10: Update eccmgr in DTSI/DTS to reflect hw/yaml
> 
>  .../edac/altr,socfpga-s10-ecc-manager.yaml    | 228 ++++++++++++++++++
>  .../bindings/edac/socfpga-eccmgr.txt          | 150 ------------
>  MAINTAINERS                                   |   5 +
>  .../boot/dts/altera/socfpga_stratix10.dtsi    |  15 +-
>  .../dts/altera/socfpga_stratix10_socdk.dts    |   3 +-
>  arch/arm64/boot/dts/intel/socfpga_agilex.dtsi |  18 +-
>  drivers/edac/altera_edac.c                    |   3 +
>  7 files changed, 248 insertions(+), 174 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml
> 
> --
> 2.35.3
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/altera/' for 20250320164622.6971-1-matthew.gerlach@altera.com:

arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dtb: eccmgr: sdmmca-ecc@ff8c8c00:compatible:0: 'altr,socfpga-sdmmc-ecc' was expected
	from schema $id: http://devicetree.org/schemas/altr,socfpga-s10-ecc-manager.yaml#
arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dtb: eccmgr: sdmmca-ecc@ff8c8c00:compatible: ['altr,socfpga-s10-sdmmc-ecc', 'altr,socfpga-sdmmc-ecc'] is too long
	from schema $id: http://devicetree.org/schemas/altr,socfpga-s10-ecc-manager.yaml#






