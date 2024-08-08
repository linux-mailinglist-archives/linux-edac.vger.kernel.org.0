Return-Path: <linux-edac+bounces-1628-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A55994C053
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2024 16:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7E11C212E3
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2024 14:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D46189B95;
	Thu,  8 Aug 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JVCn6lsT"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CE425570
	for <linux-edac@vger.kernel.org>; Thu,  8 Aug 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128959; cv=none; b=h8aakOLn71TaC1YzR7jJjnx3cuCumgKEC+Dj7AI/K6pCuF5rohk0YkbSzTk/uteIaWqGoHKmLYAX4nDyytwIYUlXfQvCwKMpn5pBJfK50SMRXjcVwwHk3Kz7/YpeJGHAsY7SlzGiUNYuT95Zjz4KLgULL+Tk03IwMoioaxn/R8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128959; c=relaxed/simple;
	bh=y0L0FYDT/HiJXa/Vqs9ia7YdEUIg2Q1aAbPNBfMmKmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbCnUhZkw/Be9LqQZJEfNnVchOstS19OZKpL90hzAo2QfvBIJx8/76oAKhlEI9wPr1ay5ne/MIQGkWGoP7s2DqDexiKUATq88d2jjY1KookW+yiKIf8EIX9jlXLRmiqeWskGeKdxGj7cVaiLcMDIZJzNIVApG6bElYi6gAD2iTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JVCn6lsT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BECEE40E0269;
	Thu,  8 Aug 2024 14:55:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aPN6v9Hz7pCu; Thu,  8 Aug 2024 14:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1723128945; bh=m8q3/2cUy55Jw660+zTI+AUlKCo9aI5QIsMiQYqtVio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVCn6lsTY2ap8h6nl0NOZGC3QzOT7J3VHmKuex976bcLBN9vlNYkKamULnzqz5RVb
	 1rZ0tAId3uTPAT5BRyInEuanXafJgQ6YXWO9AcJ6kksKc8Pe2xrLhGqizEsRp+d8H3
	 Prbi/D7JGrKgjO+U8I5+qzgXBNitYVlFv9lbWpKpk1TT6u8jwwMB/i9cfXkbg+eNp9
	 0SM+dOYFtqOKFAVaydxs17flvpoOXn7AG/UkQvoYArDkeIa/n2shrrA81RhWyazehL
	 PzmVAK3ogsF6KVrIzq0WA81AnVtkL7DZYn7HrFeLNjgu58rEaTrbWZ7XknZFhV79UD
	 YBbs6FRFkNUNfAol6HlfzoZqFOi5KhtgdD/tEBnbKRdWIYcnqQg/ZuRH/tOD8sJ6VK
	 E1ePFAPG8XtHH8XK1NBd9BbFep0w2AFBcWIh6fqKxn3XkX9YJf0ih0IzGd8Fy/mrju
	 qnTD6kwhBigq2q3ifb8149NdGqq7HHsoaxyXArUI1M1OC2c3Omb9r5rMqAkNE3jDvY
	 tmYNtiGEL57Yot4GNtVAHVccyv0MzPQ5I4kG4VscggbFQ2RLjVL+xX3hmNu+1m/T+l
	 mu9lcUO8FQtuzQXn8icIaaV7/ES+Z+EmVn49Hx94HpT/JtmPdBiykbk071owx8X40g
	 ONAhI6hNCdcEZgV93pP70bPM=
Received: from nazgul.tnic (unknown [IPv6:2a02:3031:203:3d3c:9e4e:36ff:fe9e:77ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9490F40E026C;
	Thu,  8 Aug 2024 14:55:37 +0000 (UTC)
Date: Thu, 8 Aug 2024 16:56:28 +0200
From: Borislav Petkov <bp@alien8.de>
To: Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Eric Biederman <ebiederm@xmission.com>,
	"x86@kernel.org" <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Andrew Zaborowski <balrogg@gmail.com>
Subject: Re: [RESEND][PATCH 1/3] x86: Add task_struct flag to force SIGBUS on
 MCE
Message-ID: <20240808145331.GAZrTb60FX_I3p0Ukx@fat_crate.local>
References: <20240723144752.1478226-1-andrew.zaborowski@intel.com>
 <202408052135.342F9455@keescook>
 <6273D749-9CEC-45E4-8C56-FA3A1DBE1137@alien8.de>
 <SA1PR11MB69926BFE8EFDA7B3C3D84560E7B82@SA1PR11MB6992.namprd11.prod.outlook.com>
 <CAOq732KXwsKdht55E-Z18choiAYn6dMpXc-TD15B7MOUH1fpxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOq732KXwsKdht55E-Z18choiAYn6dMpXc-TD15B7MOUH1fpxQ@mail.gmail.com>

On Thu, Aug 08, 2024 at 02:01:43AM +0200, Andrew Zaborowski wrote:
> Now I'm not sure it matters.

I'm not sure it matters either. You're adding all that code and
task_struct member just because the kernel sends SIGBUS on a memory
failure. Oh well.

How is that more beneficial for the overall recovery strategy than
killing the current task? IOW, what is the real, practical advantage of
this and why do we want to support it indefinitely?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

