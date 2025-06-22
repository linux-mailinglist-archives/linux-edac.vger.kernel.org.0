Return-Path: <linux-edac+bounces-4204-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9C6AE3112
	for <lists+linux-edac@lfdr.de>; Sun, 22 Jun 2025 19:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98F43A8245
	for <lists+linux-edac@lfdr.de>; Sun, 22 Jun 2025 17:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C8F21B19D;
	Sun, 22 Jun 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OMYDTC9h"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C364C219314;
	Sun, 22 Jun 2025 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750613008; cv=none; b=JFHZABBFjL0rpD65+Zo1ONBMLA1aiKndM03j26UAzJL9bZHFYI6IqcM0bS5u/9MjxKYgaRNOmG5rP9amN32vDMp2RH+q4KdvkulxVzVqD+QnLEkh/JemJq38FDZCxN5e3XpX0Hdx8ofR2qLf2dlTwmx2ZUhkqTgXNDLNNO1b8KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750613008; c=relaxed/simple;
	bh=mRaO2bikt5zxJObCoqZbeeoG8CYmgAo7W59s9t/j8dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpZKYOS3n6M6J7ztzykeDAXAlfCjYSHi0vVI279CbXArAEh7/Mymu/YNevB8weQMSv+jT8I3Coj8wTrAQdqDtqiqFYgZqw70QA8lyFw5vojtMo6bPDAxiz7/XM4pw51euKNSbeCLByHM1O8C6uMV/pVYKye+drBF4SbDKnRWnDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OMYDTC9h; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 17A9A40E019B;
	Sun, 22 Jun 2025 17:23:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id f7YY-K1QAk1t; Sun, 22 Jun 2025 17:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750612999; bh=WncQpBKifC/f9nB7VhvoMXozMjF+fB10WqvcH/oQckE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OMYDTC9hbbbtV1yL7jkIhS7Mj2RuQ7tWSou2s4Xl+MqXh5AtTQBGNI5ltYmM9huLW
	 xGjcrSVxHqkS4DKlwkayrdlwE/S/5ovlcbwnwTIFm5+Jsr3iO/Lwq4uqNKFNojYPNU
	 qPLZ+Dj5omyvcmA+yPgRlDc25xe/J8pWiMZbVx/cO3Hdl3ebJFN00vmeNNDZMlJG76
	 u7UXsM9rm7u9qJtqd0ainuY9jReae5hx/L24UqHOMwFgokZMcAZWxjcxV04aG6jb3E
	 FYoFB3Ey51OKHoWwkIi5jBed8g/Z1bUcwK8G8t6U53+cKytcqNAAguE0DFoRD2x9n7
	 MQwN6qIxJkiw5wgB01GS76UAMVgPxIKfAxrKuDZAd0q7StlOR06F9Ymn67SdGUcf6e
	 qcWcdZqM8IObkjuf143gEi013Cj8zHN756y3je2DnvZoFWaFRb/TjUvehgaA+XhIEx
	 ocGP38sjxiG3NDdqCIv8gqzYIYT4+NHYtFuD/Fz53b6yL+UqNiQA/nRvGoEGnsEFZH
	 d8vuj6vCbFA0ENbOGHOaq3jL8OhDnH2AdXz62hu1xMgjuT7mX+Qlntr7/Q9Jy1eSKv
	 YHNAcKuL5xhx2r1lMEWWSECpp3NNoau5bk8+5XoaN9BIesazEdAwQBnQwr5S1ritnX
	 JOx5vkb8lctm/Puvew4E4uC8=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA25440E00DD;
	Sun, 22 Jun 2025 17:23:11 +0000 (UTC)
Date: Sun, 22 Jun 2025 19:23:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Borislav Petkov <bp@kernel.org>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac <linux-edac@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: EDAC: Drop inactive reviewers
Message-ID: <20250622172306.GBaFg7-pNWuwUYDuIb@fat_crate.local>
References: <20250622161943.4700-1-bp@kernel.org>
 <20250622190848.0eba2a3c@foz.lan>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250622190848.0eba2a3c@foz.lan>

On Sun, Jun 22, 2025 at 07:08:48PM +0200, Mauro Carvalho Chehab wrote:
> I can still help reviewing.

There's a difference between "I can" and "I do". :-)

I'll add you back when I see Reviewed-by's. Otherwise, there's no point.

> Yet, I waiting you finish your
> review on my last patch series, as you commented only patch 1/5: 
> 
> 	https://lore.kernel.org/lkml/cover.1725429659.git.mchehab+huawei@kernel.org/

https://lore.kernel.org/r/efbc8109-1854-43b2-bff4-095ecd5970cd@os.amperecomputing.com

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

