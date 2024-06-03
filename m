Return-Path: <linux-edac+bounces-1174-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BCF8D8B49
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 23:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827CD1C222D6
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 21:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C006113BAC3;
	Mon,  3 Jun 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gt1IySjH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3101B13B59A;
	Mon,  3 Jun 2024 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717448810; cv=none; b=FtvPMjZzZJabDyo7Fai2VcNqQyw8tXlGTcqvUqzk0UhLXIJJbRpG/A+q7li8zF+2HBXHgtdIepBt+lX9/aLU61GHHCwi48+a8XxOpj3Z54fxMPQXwq53YYt4VjW8us5XDJx5qCeV/DsKwnK4n9KTsGfWCg3Ifu6Jqi3q3eUTkXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717448810; c=relaxed/simple;
	bh=4cBQGxgrSazq7k/l2DAY6osPrnyXVquf7jm9WI31PWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uS9fKN8GvURvXRMRe+cJw1eYae3jwVoO/f7V5eVLU82b6Uu1R5Wbi+Bq/edOfmn9fk3s9lF5i84DraWYz20amPi78x7JVcyjzCCt2YPx6myI0JlwjzVqqxTsjiWvYN0wbCYNUdwkicV9e75GUL6y+BLCaspe+tssW3rwQSaYWvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gt1IySjH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F069540E016C;
	Mon,  3 Jun 2024 21:06:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NEhoUKX2Hpbb; Mon,  3 Jun 2024 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717448801; bh=RMkKY+myXXlC2RF/63uiBhRK+XJsOp9KGZ1xlPkX8Wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gt1IySjHAPFRl598hoItEFJE5aQhaWFUsy7II6CZNrItrJOMjK+I+IX4kLJRJncAP
	 o0TUJFdFOOzhFQ84UQhDokW6e3QIFweVlUgqPgrXg3XbN/usrzCD/xEMMIfvo/jXts
	 tk9Bfwyt3x8hh18jjardrRLVlkyhp6bi4ZCDnZoK9ms7nsJZNGMoP/RB5ea7w0tbqe
	 5krFq5oyIJQaC4LCt5gNqSbqt5PjpEBx+TN5r/oaZ/PQtaLZVry3ymOUcKV/xlKDkj
	 woZyU4epYYZ2zhBxZrytqb6ZCdgQav3M+tmaI1aUWGCVh7s591XRdnwsPlJJkxM+78
	 jYqVg9zo9DHo1kS0GAVVH9CniP60BH/GU+EZsNkMbDirKehTxUJYMYusytV3eQommz
	 lDBMHGOczwTfs1pBzNK6xkipwNP8ZNTEBHFleOlIjdDw1kPnMzjZT9vpkKX3eNsg9l
	 Lj1Yb5KBfM9uPL4FY2DmJxnHKdALYcWCgIngR8GieUJgG6rQkBQ87e3VD5+ToZjGOj
	 LVU0pFUfz94tLK05e3OpozeQG0bMwXg4qWWp//YIOegeLCS7qxfg7ABydFalmyHbfv
	 3KL7FxMv1OK2cDDHNS+JuPWp+oKxC1bBbOJihO+vat4de+EzrIHESEMVW4LMgLd7Rn
	 z5C20DS0Tf7u5/Z1eRh5Ca+A=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 12B2540E0081;
	Mon,  3 Jun 2024 21:06:34 +0000 (UTC)
Date: Mon, 3 Jun 2024 23:06:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: John Allen <john.allen@amd.com>
Cc: linux-edac@vger.kernel.org, tony.luck@intel.com, yazen.ghannam@amd.com,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	muralidhara.mk@amd.com
Subject: Re: [PATCH v4 4/4] RAS/AMD/ATL: Implement DF 4.5 NP2 denormalization
Message-ID: <20240603210627.GMZl4wUy3RKS9a0Jzo@fat_crate.local>
References: <20240506154605.71814-1-john.allen@amd.com>
 <20240506154605.71814-5-john.allen@amd.com>
 <20240528102344.GGZlWwsJzibnQfuNYW@fat_crate.local>
 <Zl4vIkNNzP+cKSYF@AUS-L1-JOHALLEN.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zl4vIkNNzP+cKSYF@AUS-L1-JOHALLEN.amd.com>

On Mon, Jun 03, 2024 at 04:01:22PM -0500, John Allen wrote:
> > No lazy definitions pls:
> > 
> > drivers/ras/amd/atl/internal.h:37:#define INVALID_SPA ~0ULL
> > drivers/ras/amd/fmpm.c:119:#define INVALID_SPA  ~0ULL
> > 
> > Unify them.
> 
> Is there a particular existing header that you suggest we pull this into
> or just create a new one under drivers/ras/amd?

internal.h looks good.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

