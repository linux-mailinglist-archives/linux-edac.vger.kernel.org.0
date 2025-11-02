Return-Path: <linux-edac+bounces-5286-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BB1C295F2
	for <lists+linux-edac@lfdr.de>; Sun, 02 Nov 2025 20:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9860B4E78BC
	for <lists+linux-edac@lfdr.de>; Sun,  2 Nov 2025 19:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7CA2459E7;
	Sun,  2 Nov 2025 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Xv0Y59ya"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4852A282EB;
	Sun,  2 Nov 2025 19:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762111565; cv=none; b=Sl/Pa8kxNbxFIhSjolcXtfWAn/m4pXADGbDufAJBUlpMf8Y+MHdrZnYcJAn8gCVf0zJH9xiKJsls/XthpwrkY19V6gJ7+PGcFm44HtHomwDq6ooaCLWD+U9I960nAcLaiPVEQXmn9S5n65UNbLxShVeh2O+vyx7u2of3i0D+FFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762111565; c=relaxed/simple;
	bh=N2Rjqs6EjdnWrm92Yc01jMY9XXB2tAieMeK19U3yfIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaZgXmDz/GNtxEN7JH6G5kt4dbPfrRc7T6ZRuYTXz9e/lgb/Rm85gj9rNwwE0EKvZ8/+brPVIYUNPgiFzG3tBZ6ZMbHPAwru4rrla43bfkLbNl1WJ3E/O6Gbqe3u/1lRNALheeGR4vBAnUxvwFw32Gam3jJXL+whfY/6NklqHYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Xv0Y59ya; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6F31D40E00DA;
	Sun,  2 Nov 2025 19:25:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aSqncGFXdVQG; Sun,  2 Nov 2025 19:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762111550; bh=uRFg5lDmqZtFXdEKHj+WrhDvTqY2B9Vi7ITLdTPfOg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xv0Y59yaRdkHR5wOm83QfLd+JAq5mdKCC7ytqhqiLVr5hG7zmcZcBG7vRlmcJgF47
	 7I82z2Z5LLbRBFivMByL/TnyqLy0DSCrY0CPtVONTEiwI8jDj+om34pT97hZ/eo/iw
	 eqYpM8nrrUL7iaxw/gj0BDTzwpviaLYGho4EWYP6A4yFI/5UvF2LL4/jirCsMB07h4
	 9v82wN7ApisgkbwtnHPItvl70GtuvKPI2/Fbya3rUVkPHYhmJ1BIG/mFSkdOjdSDrD
	 pqGkB+ly03ihIX1lvNEfEhsASudx1DyKTHQK+Tv0DObzWWffVzVPL/vr6vb/Yy6a9p
	 Sxflet+WZ40B9HqOtfZ4aVvq0M/jaTfZ9DZ0yuTC27wTqaXRD8mk2soL2QMkTJtm9B
	 ijH76iwgYjBxOptODf4jtLZPAVZDqCzI7J644JF+cLA0zMexNxnl+YSFk58ebLZ4/a
	 uZZesCA1yOI0HDEdw0eBnCM+O5yvXUEEe66pZkAS3EQIl+P7evgf62joaJWVEU/2sq
	 7MN7+r/EQgR6Zb5KLiMwhw0rj2k3lu4orMCkwWMnfTAer95lKL8l/QkAm3iHTgDooi
	 FuEAasCmEnGr0VpTEwahdT0D7XMSzKuPHHwe06LdmnV78/fbimYBr/adoRBqJ8TzQH
	 pkr8YlQREZi4M3c71hmln8No=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 144F640E015B;
	Sun,  2 Nov 2025 19:25:40 +0000 (UTC)
Date: Sun, 2 Nov 2025 20:25:33 +0100
From: Borislav Petkov <bp@alien8.de>
To: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Cc: dinguyen@kernel.org, matthew.gerlach@altera.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, tony.luck@intel.com,
	linux-edac@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] EDAC/altera: Add IO96B ECC support for Agilex5
 SoCFPGA
Message-ID: <20251102192533.GCaQewLa8SXiNgnS4M@fat_crate.local>
References: <20251028092232.773991-1-niravkumarlaxmidas.rabara@altera.com>
 <20251028092232.773991-5-niravkumarlaxmidas.rabara@altera.com>
 <20251030143051.GJaQN2m2fniYVRtBxn@fat_crate.local>
 <24d2beec-129e-4545-b777-c1c717be956c@altera.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24d2beec-129e-4545-b777-c1c717be956c@altera.com>

On Fri, Oct 31, 2025 at 07:52:41PM +0800, Niravkumar L Rabara wrote:
> In terms of savings, this approach mainly avoids compiling code based on
> Kconfig selection.

That would be the main argument which determines whether those new Kconfig
options are needed. Read: the kernel has waaaay tooo many Kconfig options so
if not absolutely necessary, do not add more pls.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

