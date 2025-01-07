Return-Path: <linux-edac+bounces-2818-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0640DA03809
	for <lists+linux-edac@lfdr.de>; Tue,  7 Jan 2025 07:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997CE18852DD
	for <lists+linux-edac@lfdr.de>; Tue,  7 Jan 2025 06:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0CF1C3BFE;
	Tue,  7 Jan 2025 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NURjcH0W"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5E218641;
	Tue,  7 Jan 2025 06:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736231827; cv=none; b=iWAkPL4y5a6if/irfiB0nmnUneOPt6l3z1ZwWvkKltLnrLBDPTLL3nLHZAEMrU0EA7KXOx7OZ+e3rM+IoYlfppX/x0Zbx4nCGDyDE2kLTAhhdvQAqFEcWCci+5qUhkVfARAQOBG3n9dCkUCDDhy3IBnFKr8TfPRa2UZUO+xe1n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736231827; c=relaxed/simple;
	bh=sRMNjrF5fzpZzIUgrg1K1oKsI7vH9kxNisy1gZ1Rk6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehw4utIZXcSroHKXHzgM22E3HkueFknyyNCwdWhovVQyWMQj3ktbqGSJe2F8HDYZNY7ou/SfDOTMa801GHyjERN/obP9rhbOXibHRWKDIeDhNFGbb/V5BMHNCd+OyQetzgvPy8WkF+0ZXB27x5uhEihVya9U+Af69zjajxwwQEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NURjcH0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53543C4CED6;
	Tue,  7 Jan 2025 06:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736231826;
	bh=sRMNjrF5fzpZzIUgrg1K1oKsI7vH9kxNisy1gZ1Rk6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NURjcH0WlnoxYYgY39RgR/KW/2Ft+UjGW3lICQbHRx7yOyQ235A/AmEKB/uG/uS+H
	 NGHOLzVsbkt5dqryuy4S5ctw82f6JS0KaT4cLre6whIdY2j06y0P/eByDft7wsdfrH
	 2Dreq3ni2S1b9Jj5PvHV9qf8mnwkfuZnWsPC/CrTSu8uOm/Z4XNf0Sibnv+12kTs2L
	 CPi5Bb8Fqw6eZSvx9XTXA5GTieY4NOcdcIUu5epbtR+xbkEncuJVWl23asDwUOo3F8
	 nfO1WSLdGiuv1P0E3QPdgNBPsWn8aZCrlDLc4vGSRyCRuNZs1Klsf9c52fV8O7ZYhr
	 rud2hBuT0Qi/w==
Date: Tue, 7 Jan 2025 07:37:02 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	James Morse <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Robert Richter <rric@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-edac@vger.kernel.org, git@amd.com
Subject: Re: [PATCH v5 4/5] dt-bindings: memory-controllers: Add support for
 Versal NET EDAC
Message-ID: <ff7wj4atmh2xgn2pqqr3bxecdkrkgaybsph4crnq7eqyrojqlb@dcwa2hlg3umg>
References: <20250106053358.21664-1-shubhrajyoti.datta@amd.com>
 <20250106053358.21664-5-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250106053358.21664-5-shubhrajyoti.datta@amd.com>

On Mon, Jan 06, 2025 at 11:03:57AM +0530, Shubhrajyoti Datta wrote:
> +description:
> +  The integrated DDR Memory Controllers (DDRMCs) support both DDR5 and LPDDR5
> +  compact and extended  memory interfaces. Versal NET DDR memory controller
> +  has an optional ECC support which correct single bit ECC errors and detect
> +  double bit ECC errors. It also has support for reporting other errors like
> +  MMCM (Mixed-Mode Clock Manager) errors and General software errors.
> +
> +properties:
> +  compatible:
> +    const: amd,versal-net-ddrmc5

git grep amd,versal-net - 0 results

Where is your soc?

> +
> +  amd,rproc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to the remoteproc_r5 rproc node using which APU interacts
> +      with remote processor. APU primarily communicates with the RPU for
> +      accessing the DDRMC address space and getting error notification.
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
> +       compatible = "amd,versal-net-ddrmc5";

Still wrong indentation. I commented on wrong alignment so that's on
me. Use 4 spaces for example indentation. (or 2 spaces, but not three...
there are no bindings like that).

