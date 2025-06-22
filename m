Return-Path: <linux-edac+bounces-4203-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F545AE30E8
	for <lists+linux-edac@lfdr.de>; Sun, 22 Jun 2025 19:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1C316E8B4
	for <lists+linux-edac@lfdr.de>; Sun, 22 Jun 2025 17:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D98199FAB;
	Sun, 22 Jun 2025 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6H6P2OK"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D60EA29;
	Sun, 22 Jun 2025 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750612134; cv=none; b=Xo6fRM4ONy0fmOjOq1gto56LQddScA/j9ZQ6w2K1BRo6FNB8/5AkGDbZX21WOeiPHj4IysxWuKe7e+BrynpU7wasDc2DYFVTCrtJY93cPIK2dUh53Wtksa9CrMzkXAtK/Xx1wzK5TI+0Ifd1bsz0rehsl9rbafD5kl1cFWVdO3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750612134; c=relaxed/simple;
	bh=lJsk2A5Wmq3V+PYvhgL5+W5h+8342uHq2gl585djuMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2izCsJjoRgXSl37ZB4F2R/t4D1/BZMWYOk6RwoCiZm6pqD1dNPGrnhFur+qApWpUaPj+4ML/3fgK2nIuVqkx8p3WuuKvPJ9qFNigkgizl3WeRCt67j8V84Qb27Ut8yQN6IH17gxTn8TDh2DCp8tEWTc6WEIeuuZ/dzL7vOwR5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6H6P2OK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A73C4CEE3;
	Sun, 22 Jun 2025 17:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750612133;
	bh=lJsk2A5Wmq3V+PYvhgL5+W5h+8342uHq2gl585djuMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g6H6P2OKbRHMubQLaT74cDnbS0OLjwtg1cfIpRaAGiPvVN3Jme2TW2xjAjm7q9GDv
	 JGnaVSxF4xDE0u8Ixwnhr9m2LKsq0DPssnQkobgTbAk77BmzzN6yC10PD8ZD0jpIAP
	 h8ChS1z/UngzJduZaIrcb5L/f+1MQRJKqreJmFjsNZmKwe8CmeER5D5+9+Kkb5m5TT
	 W230bzPKhgIQpTkXU4f1qcSFWP+1SmjvV6ZmQw+MCHhhGrdhkiajTzdegqV+3ntFt4
	 8DvMFF5Mk9I8yQf7MKs9ZUew14uK1rT6zwZL4Mkvkevym0d0+PlSX/b60OkTgVEEjN
	 aE0dh5k4mor6w==
Date: Sun, 22 Jun 2025 19:08:48 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@kernel.org>
Cc: James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, linux-edac
 <linux-edac@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: Re: [PATCH] MAINTAINERS: EDAC: Drop inactive reviewers
Message-ID: <20250622190848.0eba2a3c@foz.lan>
In-Reply-To: <20250622161943.4700-1-bp@kernel.org>
References: <20250622161943.4700-1-bp@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sun, 22 Jun 2025 18:19:43 +0200
Borislav Petkov <bp@kernel.org> escreveu:

> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> I know y'all busy with other stuff and don't have time for EDAC review.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  MAINTAINERS | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3ecb44458a7e..748c0e732da5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8579,9 +8579,6 @@ F:	drivers/edac/thunderx_edac*
>  EDAC-CORE
>  M:	Borislav Petkov <bp@alien8.de>
>  M:	Tony Luck <tony.luck@intel.com>
> -R:	James Morse <james.morse@arm.com>
> -R:	Mauro Carvalho Chehab <mchehab@kernel.org>

I can still help reviewing. Yet, I waiting you finish your
review on my last patch series, as you commented only patch 1/5: 

	https://lore.kernel.org/lkml/cover.1725429659.git.mchehab+huawei@kernel.org/

Regards,
Mauro

Thanks,
Mauro

