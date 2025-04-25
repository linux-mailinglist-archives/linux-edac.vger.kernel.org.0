Return-Path: <linux-edac+bounces-3724-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7244A9BF1F
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 09:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485F99A01F6
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 07:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3B32165E7;
	Fri, 25 Apr 2025 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVjFmQ3R"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC2B18D;
	Fri, 25 Apr 2025 07:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564624; cv=none; b=pp4QaNcxwkGP0IVB7dOput/pHLcTwdo3y/Eq+1elo4MiMG71ZUsdu2JWhLx9zyG2ISTtiunZKEWH7dnQ0a7VG0EWzbNvEUMdNWcfS5PCm6Yd0x0JyDD2uo3LH1HILbBSDFmclKZtMAsBbc7Qfyus/G3u1KZoSIlQkDeSQzVhkcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564624; c=relaxed/simple;
	bh=TLBugTIgN7wDj7dyXhHbV9/N8AkEym5KkLQsjxNk0lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8XETkn6A+cxSgtoGmnoooWCzrDmQJOmR9pOAoAftrfQAy4RTA0U2C3VK99xpRw385pv3rUOxz6zcGuGRew+W7f8zXWqRfGrMuHI1HTj7rqw6e1QOEk8ClGE6sikuAeeeAfLKLmKUlHEPkUj49alBprm7xQ1ocQhu914WrfDKgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVjFmQ3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31955C4CEE4;
	Fri, 25 Apr 2025 07:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745564622;
	bh=TLBugTIgN7wDj7dyXhHbV9/N8AkEym5KkLQsjxNk0lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVjFmQ3Rx3JVx4mAf3KNUgkQKu/WAU0LwFqu8h1Rh/9/C0GNek6Hl9kJuqmeqkQuL
	 3HxADlUeFLbwm/QmvYUlq0VfMdZAHenGTJ9pTS1Tzk49nnZpLtB+5TCHZBDMfvgXoV
	 kcYLukObdLsvnaopPzX9V1R670PGp/Fa1EuWt7xB2wrB7epWuP45BVMAtxDBWul3s7
	 YgNvH+8GOAGPaVcTxQ5+L9qkBU1Z++DU4lFyeWdlnIsHpF0qP1ZjWLiKdPpEvZnLDQ
	 tpKF+TzUuN/CqFMgidTzJhzM6Y1vdTiobsugUO6TLG5WCjwzb7v6En/7mwLjZXipNa
	 x+mhjiGCoanYw==
Date: Fri, 25 Apr 2025 09:03:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-edac@vger.kernel.org, git@amd.com, ptsm@linux.microsoft.com, srivatsa@csail.mit.edu, 
	shubhrajyoti.datta@gmail.com, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	James Morse <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Robert Richter <rric@kernel.org>
Subject: Re: [PATCH v6 5/6] dt-bindings: memory-controllers: Add support for
 Versal NET EDAC
Message-ID: <20250425-smiling-groundhog-from-ganymede-dbd626@kuoka>
References: <20250424132118.17074-1-shubhrajyoti.datta@amd.com>
 <20250424132118.17074-6-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424132118.17074-6-shubhrajyoti.datta@amd.com>

On Thu, Apr 24, 2025 at 06:51:17PM GMT, Shubhrajyoti Datta wrote:
> Add device tree bindings for AMD Versal NET EDAC for DDR controller.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

(As DT and memory-controllers, so this can go via EDAC with the driver)

Best regards,
Krzysztof


