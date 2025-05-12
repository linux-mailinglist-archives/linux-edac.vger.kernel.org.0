Return-Path: <linux-edac+bounces-3888-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6211AB4500
	for <lists+linux-edac@lfdr.de>; Mon, 12 May 2025 21:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63D4467D38
	for <lists+linux-edac@lfdr.de>; Mon, 12 May 2025 19:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A159A298CC5;
	Mon, 12 May 2025 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSnwCH/0"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7303925332D;
	Mon, 12 May 2025 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747078226; cv=none; b=oW9YWZ+s1p1mpZST+FFJNTgwVHtqdJ+cPFF24GSzaT8V/KoWztAYAoiCi5qgNXBC193roqJ84nPWX1ivfOUfuyaingb7CficgigBSGIa5p2Sel+pm4bP5cY9C7qngOeiCAqURBPHx5DGofbTmGBF9FM2k4IWtihadXA0NSHkO+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747078226; c=relaxed/simple;
	bh=SnfXj5AiXjTNiB+Fi6IRuaS5N/lfiblfFGY2z5N4g6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRWUrkT1/WdaVbWzYtRuZOBT7wjiyrtmQFV4KNmEq6/Jr3X603vyDqBO+EjHiesEcRkS2gbYqnP+NMgc2A4DAd3614E8XwzVi57ZgEcGOmEiPWM/Xbi5xglo9U3KkZ2hBPDvZIsIU4yJ59bWB9q+l1J2vT/9ZH2BqFgCGdwLiAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSnwCH/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED12C4CEE7;
	Mon, 12 May 2025 19:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747078225;
	bh=SnfXj5AiXjTNiB+Fi6IRuaS5N/lfiblfFGY2z5N4g6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kSnwCH/0MiCWixLiKAZWxYQeeso/DTlx7vs8BTNUQxtyT+7yRJklPvnBUH1mFJW4z
	 mSgN9w2RbiR8/fHK+v99pAIq6Pt9v2YSjdE/SC5gzGVm5dU2B0xKIXMO7TGyXOchzB
	 8nzoNa0nTzfsVUoCDAlS6blZFZQKc4162/VzKPRlLn7yEx2vRRbVmJ0ToXbBCLk1xj
	 dcWJ18azoOjXQzdKGLaWl3knqOYBwZ2xzV7v60ijiVeBHrD05j7OME+Q/kkHr83RsN
	 LYXenR3n9MaC4D7gO8RcZIgMIfKecDsPrVMDKUqKFnZciKYmo8Oh9y3fjLe06JjeSu
	 Y95gkvrf8aFOA==
Date: Mon, 12 May 2025 14:30:23 -0500
From: Rob Herring <robh@kernel.org>
To: Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
	Marc Zyngier <maz@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: arm: cpus: Add edac-enabled property
Message-ID: <20250512193023.GA3708326-robh@kernel.org>
References: <1746404860-27069-1-git-send-email-vijayb@linux.microsoft.com>
 <1746404860-27069-3-git-send-email-vijayb@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1746404860-27069-3-git-send-email-vijayb@linux.microsoft.com>

On Sun, May 04, 2025 at 05:27:40PM -0700, Vijay Balakrishna wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Some ARM Cortex CPUs like the A53, A57 and A72 have Error Detection And
> Correction (EDAC) support on their L1 and L2 caches. This is implemented
> in implementation defined registers, so usage of this functionality is
> not safe in virtualized environments or when EL3 already uses these
> registers. This patch adds a edac-enabled flag which can be explicitly
> set when EDAC can be used.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> [vijayb: Added A72 to the commit message]
> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> index 2e666b2a4dcd..d1dc0a843d07 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -331,6 +331,12 @@ properties:
>        corresponding to the index of an SCMI performance domain provider, must be
>        "perf".
>  
> +  edac-enabled:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Some CPUs support Error Detection And Correction (EDAC) on their L1 and
> +      L2 caches. This flag marks this function as usable.
> +

Since we don't want this on newer cores, add an if/then schema to only 
allow this on A72 and whatever else you end up supporting.

Rob

