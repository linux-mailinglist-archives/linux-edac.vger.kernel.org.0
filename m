Return-Path: <linux-edac+bounces-4323-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46850AF9247
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 14:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4F017F270
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 12:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05C02D63E1;
	Fri,  4 Jul 2025 12:15:13 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C816527978D;
	Fri,  4 Jul 2025 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751631313; cv=none; b=igFTm3oz7vaoH1A7AHj2C55evG7uu3PEd6UF3RseNYKL3NPccCR4g+qJKs6PTHH4QsyBeAdmgXl+H9B7f+4VoiFdLsojnOucaJjC/O10TzW6z+A+9rXkhRlCK+ehR0ty96i8bqqHLYP5JxRVszPXgaUdG4MZW1SK0oECqpXFrkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751631313; c=relaxed/simple;
	bh=cvq8TxQmKqnvSD9IOkDgsrA6NsfH+VP5155bLAsi7/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyJxr4nqeNpm7QxpOZWrWeRKwWufjXw7JJnYw1AJN0Ei9KUYoIi7UkIhdyLzGRktEQAJlbong7Z3KbcBMQ0nya91LIYq+WQfKrfonfQhW4w/L9CXPbUmkkf4YyOPBRT/2P2uEey+JIZPuZTqMAp4ylqWifILJ1LHNMxImg2fxR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0c4945c76so124554966b.3;
        Fri, 04 Jul 2025 05:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751631310; x=1752236110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBY1molXuBQZx9UChKE37Gcsp4aSvE5DwbOEwMmllnQ=;
        b=Xiq0Np5+34IxQkSgU+BeqptDsLc4wdcLHQbnrZZWGXMAKfTrYabg3kqE2IwlVZGlLr
         6LFOQeOh1EM4wRqXl6EpG/VU17nTGi6ODbpAViOAp2+7je9rawSf8+QFE00DGqa6V4LK
         ipv+hKDT8iCuqUM2nZ1ZDMsP48CKyNxhLUetGorE90aGt9paoqRMngi5N+aRzYPvVu7W
         81ET/PvXW0ZxoSC+oLLa8zrA1Ty85tv9xD+JHGMPumIEi5M9DZSt3hIAKcawAnmJR9kq
         Q/8697WjT22BfOs/KkmpW3hf6JpEWVheW994UeY1fRQGfTRHPSWTaMZDq7Il6eher5oJ
         iDIg==
X-Forwarded-Encrypted: i=1; AJvYcCU4GNoPloi5g1MHKe2kTJil6Ipzf/Cjt5kfFwRan1iQ7QZlRVIwjueEijBTYYw3MV+aAnYrGD1bP/G9UQ==@vger.kernel.org, AJvYcCVJIt6cHF5tBgf4aKpP32OdeW/iSuUYPzxcCyDj5EBauDVImyEFLgcK4fpsi0Qs2L6mYS3yUFkhAKvT@vger.kernel.org, AJvYcCWNvFckavjBq3WHu0ReQreLYaNWGtGmNZKIX2dBWB2ltNwFiBaan74ni+H0ziHLZuzu6R+eMMi6QHle@vger.kernel.org, AJvYcCWvFeWALVZKrULyC9NAtWpTY4fk+AAqQQAUw7j3A/Mdwr47LF+vqar6s/fMWiATP9GR7NpygrmXAk2UPrs/@vger.kernel.org
X-Gm-Message-State: AOJu0YzaoS6qYIfxD6ImbLr+wff3pgwijnsBauCqhCmOfeSeF0IhY3dF
	sPO0unIG3ngCMayTZOIUjWdnQb8zSHvmz78wbvU1TRSvcFJRV4i7CPQC+vQcSQ9d
X-Gm-Gg: ASbGnctU7RFLn1iaulOFThn/WR9OL6h27SPbiT4Q7JXhAeED0+LCJdJI9vQUmkHUQy8
	nQBhThK6yHn8VfhsfgsyLCNW8RqjfnvFN5a8sI6rDJ2W86Eo+jPAkTuxdmepCNKatw1EG3MrGsW
	eV3rFdv0p93uZGVi9bCfvelKs/U2CNJ/kqNmahdLX7H6GMMsviFqXrY6r3Xv6AHVBYQQUPB2uay
	Xzhz2u5eBpq2HluyUxKww7ZJ3IZrjmuhqx+mi3I6mCFaAj3Z56wOskLNxJVW9+lt0W4FBgk/Zvi
	p7rzQsHYpaOpk8Xw9ffklBhGaA1fKLYKNqmBsJ89qcuaBrEIWg4AbavrSN8=
X-Google-Smtp-Source: AGHT+IGUrSlrM63vyh4qnAf0df/fQaLU/XqzIUvOwUVgeglalPh3toeoiF0GDn9UYO4k8oc5KCqtvg==
X-Received: by 2002:a17:906:c113:b0:add:ed0d:a56c with SMTP id a640c23a62f3a-ae3fe0cd37amr192085166b.0.1751631309726;
        Fri, 04 Jul 2025 05:15:09 -0700 (PDT)
Received: from gmail.com ([2620:10d:c092:400::5:c915])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66e8c1bsm163203366b.27.2025.07.04.05.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 05:15:09 -0700 (PDT)
Date: Fri, 4 Jul 2025 13:15:06 +0100
From: Breno Leitao <leitao@debian.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, tony.luck@intel.com,
	rafael@kernel.org, Alexei Starovoitov <ast@kernel.org>,
	kbusch@kernel.org, rmikey@meta.com, kuba@kernel.org,
	linux-edac@vger.kernel.org, mchehab@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/2] panic: taint flag for recoverable hardware errors
Message-ID: <aGfFyktcuRV73Bl8@gmail.com>
References: <20250704-taint_recovered-v1-0-7a817f2d228e@debian.org>
 <20250704111954.GBaGe42gY5_xADb17Z@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250704111954.GBaGe42gY5_xADb17Z@fat_crate.local>

Hello Borislav,

First of all, thanks for spending time in this one.

On Fri, Jul 04, 2025 at 01:19:54PM +0200, Borislav Petkov wrote:
> On Fri, Jul 04, 2025 at 03:55:18AM -0700, Breno Leitao wrote:
> > Add a new taint flag to the kernel (HW_ERROR_RECOVERED - for the lack of
> > a better name) that gets set whenever the kernel detects and recovers
> > from hardware errors.
> > 
> > The taint provides additional context during crash investigation *without*
> > implying that crashes are necessarily caused by hardware failures
> > (similar to how PROPRIETARY_MODULE taint works). It is just an extra
> > information that will provide more context about that machine.
> 
> Dunno, looks like a hack to me to serve your purpose only.
> 
> Because when this goes up, then people will start wanting to taint the kernel
> for *every* *single* correctable error.
> 
> So even if an error got corrected, the kernel will be tainted.
> 
> Then users will say, oh oh, my kernel is tainted, I need to replace my hw
> because broken. Even if it isn't broken in the very least.

The information is not there to show correlation of broken hardware,
but, to flag that this kernel is running on a hardware that has
recovered from an error. It doesn't not mean that the problem is in the
hardware.  During my investigations, most of the time, the kernel was
buggy when recovering from hardware issues, mainly PCI re-plugs.

Anyway, the taints are not to tell you the root cause of the problem,
but, to give you an indication that would help the investigations. For
instance:

TAINT_PROPRIETARY_MODULE: 
   - It doesn't mean that the machine crashed because of the proprietary module.

TAINT_FIRMWARE_WORKAROUND:
  - It doesn't tell you that crashes came because of the workaround,
    but, it tells you of this workaround.

Same for TAINT_LIVEPATCH, TAINT_FORCED_RMMOD and most of the taints. It
helps the users, it doesn't not tell you the root cause. For that we
have AITM. :-P

> Basically what we're doing with drivers/ras/cec.c will be undone.
> 
> All because you want to put a bit of information somewhere that the machine
> had a recoverable error.
> 
> Well, that bit of information is in your own RAS logs, no? I presume you log
> hw errors in a big fleet and then you analyze those logs when the machine
> bombs. So a mere look at those logs will tell you that you had hw errors.

True, but, this argument would apply for every taint flag above. You can
look at the logs and find LIVEPATCHES, PROPRIETARY_MODULES,
FIRMWARE_WORKAROUND, etc.

Those information could be somewhere else, but, being somewhere easy to
read proved to be useful.

For instance, reading from `cat /proc/sys/kernel/tainted` might be
*way easier* than parsing *thousands* different RAS tools logs for you
to find what is going on. 

> And mind you, that proposed solution does not help people who want to know
> what the errors were: "Oh look, my kernel got tainted because of hw errors. Now
> where are those errors?"

Agree and that is the intention. Whoever look a crash/warning knows that
the machine recovered from a hardware error, and this help the user in
two ways:

1) Know that the kernel executed a path that is not frequently executed.
2) Look at the RAS logs if you think this is hardware related

Maybe these two things doesn't mean much, but, it is like a heads-up
flag for whoever is looking at this issue.
 
> So I think this is just adding redundant information which we already have
> somewhere else and also actively can mislead users.
> 
> IOW, no need to taint - you want to simply put a bit of info in the kdump blob
> which gets dumped by the second kernel that the first kernel experienced hw
> errors. That is, if you don't log hw errors. But you should...!

Sure, saving this information somewhere will solve the problem as well.

I thought that adding a taint would be easier for few reasons:

1) you can easily read from userspace (/proc/sys/kernel/tainted), so, it
is easy to scan the fleet for hardware error, and query the RAS logs
only for those.

2) it is shown at crash time already, so, this information will be
"free" mostly.

3) taint is consumed by kdump/kexec already, so, nothing would change.

Anyway, I am happy to add this information somewhere else if you think
that taint is not the right place.

Thanks for your ideas and suggestions,
--breno

