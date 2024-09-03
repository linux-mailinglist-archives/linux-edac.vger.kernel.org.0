Return-Path: <linux-edac+bounces-1772-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04ED969406
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 08:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811911F23958
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 06:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FA11D61AB;
	Tue,  3 Sep 2024 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LphKs8CF"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16CD1D54E4;
	Tue,  3 Sep 2024 06:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345869; cv=none; b=GSWBmgAf5GLXtxD7mCN34yBlpTQBtxydcwMbcoE7SjLI5tmv/Yv0/h2Z4qBDjbmi09QPqeyAIlgM8TFxWbDnm7GsXTM3r3EWuWMuC9Z+n3gluCkW3WMi9XPaJOYX3P3bE7Gh4DEqKi6V50pWAxmHYX2CoZ4PQGV2v3JM3A80Q8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345869; c=relaxed/simple;
	bh=L8/JzkSa3jocuq+XpNsY5gjIzY2JH8JzCv/oAmQ491E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYHMIWdiwqN1/zEJPPVHoPkTTOZ4+X7aNDM9YdO1WDueKGyvd7FNb/+/F6SLiUMoXjaFV3fbLT58ZBz4DEtGpFWdIPU6Jg47A6tSNVf0R3mtQHjqY1c9Ord9g4qkaPxwg1+UXOC2XOtUiSs0aW9jolwbHGW7CFrJtS1sG1aGI30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LphKs8CF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A88DC4CEC5;
	Tue,  3 Sep 2024 06:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725345868;
	bh=L8/JzkSa3jocuq+XpNsY5gjIzY2JH8JzCv/oAmQ491E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LphKs8CF+JBJPUvK9DmEbTAbuXds+pgPKhChhvnzbphKiSDShoy0LfeSdwARNoI+h
	 6EKZmTdpoK/HSOT7qLIw/iLssjofQ91+cypmdV01sNIY1ToAjnIyDMx9ceM0VLwQAb
	 +HSDYADspFAz2dQ82f5Y8/ErNkrvcXt8++dRXtnAbru3IekvrbcTfm8eysk3P1XIsx
	 6hsqVBym1PGEhqabHPPW/b5SrBwTyg8geCHD3ygD5tQPWCzfFowOm51W0q/AEi6uhs
	 UEauzo91MOLujuoBAjIrUEH9TLxz0bGaPi/dwYpQZK2JoPsBKE65FZCVW62ENoWrqv
	 JmeZuWqHV8/7A==
Date: Tue, 3 Sep 2024 08:44:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zhao Qunqin <zhaoqunqin@loongson.cn>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	chenhuacai@kernel.org, linux-edac@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@xen0n.name, bp@alien8.de, tony.luck@intel.com, 
	james.morse@arm.com, mchehab@kernel.org, rric@kernel.org, loongarch@lists.linux.dev
Subject: Re: [PATCH v2 1/2] dt-bindings: EDAC for ls3a5000 memory controller
Message-ID: <rbatux54v2lj34osoee6dyu5nia3ucozjebvob2uxpim3zt4cz@zyzztjdwrv6m>
References: <20240903015354.9443-1-zhaoqunqin@loongson.cn>
 <20240903015354.9443-2-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240903015354.9443-2-zhaoqunqin@loongson.cn>

On Tue, Sep 03, 2024 at 09:53:53AM +0800, Zhao Qunqin wrote:
> add device tree bindings for ls3a5000 EDAC driver.
> 
> Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
> ---
>  .../edac/loongson,ls3a5000-mc-edac.yaml       | 44 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-edac.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


