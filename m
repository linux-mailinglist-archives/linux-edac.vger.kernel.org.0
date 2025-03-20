Return-Path: <linux-edac+bounces-3390-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB87A6AE9A
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 20:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0150488402F
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 19:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4723E227EAE;
	Thu, 20 Mar 2025 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAHO5Ahm"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FCB86355;
	Thu, 20 Mar 2025 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499258; cv=none; b=K8JUPikgQLaNYlBh2fLu/lXLOVdNw6JX2OS0ufGYUFU2Yw8fYL8Vg2IsI5hs1LH9SvHeo8VBG0S8sEHwp/zRWTyaHYFiLQX9CK1xmXtro9UFg9SIAu3xvpFlKBN9Hgel7XeXJpY5AHiBceC2MbtpCOxvBncftgag37c5IUUbJ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499258; c=relaxed/simple;
	bh=JQ9Z0ApuZ1Vvy4/5Qv2+rvakyfM7rmvGaKi76+GvZTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYG43gBrhbm+6rqRzZ9sI/HJzA7VJQ5UE18c2qLaC50k7tvxdjGhnrGzf69cS8ihRyrkEKRNQRcdPJyWK3veMpE29Qryqpte1Y2ZP+C/XbJhrsWKkJg4ODPTf+DojTs7eldzHOoUWrtv/qDi1XkbC2p0hMXc8yAgWk8XoRtPoDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAHO5Ahm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7213DC4CEDD;
	Thu, 20 Mar 2025 19:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742499254;
	bh=JQ9Z0ApuZ1Vvy4/5Qv2+rvakyfM7rmvGaKi76+GvZTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UAHO5Ahm33cnMGeNTzsiXfrr7mxvC9SBP87umUQlBAD4Ll3yP1jaQwWHVsfB4GcHY
	 58tt5c9ByaCZO+trwteQ/xDF5eLer0t7el1A+vtQDAB4BgGzO7ACYiQOgTVTh7JSfo
	 /a/Abl4jclTYDlnDcK2C39Yjs6lbtbR+L7ZoryNZpu8xBH/XsjO3OC3LU9/wtA3Nw0
	 ruMy/jp82JFE9ew8p9nu/XNG4MEhaPOjkdGMRvkZuUdmzIXuBwS4JnhHFzE9KFkTAl
	 yqZOZ3oFMfcYveTJIBptAmp1pyc9zrHUZaFPw4S9HUJgb4Rw+jHkMJ8WUYJ1IKe3rU
	 31gn0vKk9XkjA==
Date: Thu, 20 Mar 2025 14:34:13 -0500
From: Rob Herring <robh@kernel.org>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org,
	bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
	mchehab@kernel.org, rric@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: agilex: Update eccmgr in DTSI to reflect
 hw/yaml
Message-ID: <20250320193413.GB750632-robh@kernel.org>
References: <20250320164622.6971-1-matthew.gerlach@altera.com>
 <20250320164622.6971-4-matthew.gerlach@altera.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320164622.6971-4-matthew.gerlach@altera.com>

On Thu, Mar 20, 2025 at 09:46:21AM -0700, Matthew Gerlach wrote:
> Update socfpga_agilex.dtsi to track the actual hardware description
> provided in altr,socfpga-s10-ecc-manager.yaml.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
>  arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> index 1235ba5a9865..708cb8e762b6 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> @@ -602,8 +602,7 @@ sdr: sdr@f8011100 {
>  		};
>  
>  		eccmgr {
> -			compatible = "altr,socfpga-s10-ecc-manager",
> -				     "altr,socfpga-a10-ecc-manager";
> +			compatible = "altr,socfpga-s10-ecc-manager";

You are breaking the ABI here. Before this series, the driver required 
altr,socfpga-a10-ecc-manager.

>  			altr,sysmgr-syscon = <&sysmgr>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> @@ -619,40 +618,35 @@ sdramedac {
>  			};
>  
>  			ocram-ecc@ff8cc000 {
> -				compatible = "altr,socfpga-s10-ocram-ecc",
> -					     "altr,socfpga-a10-ocram-ecc";
> +				compatible = "altr,socfpga-a10-ocram-ecc";

AIUI, nothing used altr,socfpga-s10-ocram-ecc, so this change is okay I 
guess. Normally, we'd require both because there might be some 
difference you find later on, but here you could just look at the parent 
node compatible.

If it were me, I'd just add the compatible string in the schema and 
avoid the .dts change. That would have been less work...

Rob

