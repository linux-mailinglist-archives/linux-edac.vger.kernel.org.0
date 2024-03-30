Return-Path: <linux-edac+bounces-858-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4478F892A88
	for <lists+linux-edac@lfdr.de>; Sat, 30 Mar 2024 11:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1BB1C20DA0
	for <lists+linux-edac@lfdr.de>; Sat, 30 Mar 2024 10:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BCE17745;
	Sat, 30 Mar 2024 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecciOYqH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019FCB67F;
	Sat, 30 Mar 2024 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711795141; cv=none; b=prixWSyT1gYB5C6QfSHnOQ1lPXCvHZUlY4gUWVT9aeWAsy6ooFRNNi6QAFvBc9XMFcMTlmTLrBYZLtQslDLeZrhiDpllWImZy6xr4JG5YHAf/pWiTUvlz8GR9DhFgyYkmRGjYBUst/hiKdGpR4AXEOWwohqOseGiQnZOqfxXLc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711795141; c=relaxed/simple;
	bh=Q+ETMHT6NZUsD0uPUUOoP8OcBmMiw+m0U8Cey9kzIdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PauFmgXM9D5cprcwTyMpeOhvE6hQ+97qzOoSCwv55yNBmxhmhczG37YO1SNHsTXhEtKuzjUg4hrrSmjkIjbL7wpngdq9GEdnib7PyCndo0hzwEpuZaCo71CeENzBxRTzsHxyxe9WV1hsdrXRNZvpSSm91dgcJ1L8LAlzFeT4Dlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecciOYqH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34100f4f9a2so1862015f8f.2;
        Sat, 30 Mar 2024 03:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711795138; x=1712399938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZWMsgzXS3+hw0eC5ZzOG3CrdPB8WGzpvayF1RWuekw=;
        b=ecciOYqHXGQAW2HRnq8WbKQwZrhz9gfofsbmPIOjghiebCqJ4HkLMWyKaQ8D9n4gDA
         osjDvFO4+EouKRMmjQf4lLEsFH7MM3CG/Su2Gin99ACV3DoguW2WyK79BWGZLDLfwH0o
         hjNM/FwqKBww3uEbomETeunSm6Q4JWLuPEHw9BwU+wp5xiiFxIHrIWMOn8YGqxXW7iO7
         kZFlZ2wEf4/Egf099cmnWrcXwV8deYb4Bye4b34qRucsZhB003Xvvnjuo3dBiIFjIMGr
         mXVFQqyy3f6cm4KWJ9kh/c6tpOc1TuC40XVKWZk96+LWOULOmI0BJTK766uoigCk3c20
         OstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711795138; x=1712399938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZWMsgzXS3+hw0eC5ZzOG3CrdPB8WGzpvayF1RWuekw=;
        b=sXM54fQw/AlQyCC1Jzp1FhscJDrSa/p5pfdqAkKljKlXS14NtY1mvJ5YcN1jSQ+1PY
         7PN4UcMRvXRfBOJpnuEMwAH7imSvGMnFCPgHyeZUWUA6Ur5wbQhb9JSxUDB6+HGZ/5je
         z4jXWWCNMiL3Y6tNd6hBj8ES9b/326gcTYt0ks2pLo2whH00uULADZiNKPjMeDuLAyUR
         BVJzPEK5ARyFYRoK4T+n3+Kvu9FPjyZKhi1IXYwb9MXtyt4+Ij9LTsIj5TCNRXBHr0nq
         m6k+xDSebV18Qddx+l5ks+f1SIe+xpDFmLuxIRBmYBKcUtqf39yhSyGBOVeClqXrAo5k
         oXpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk3UAfyMpQvPL5tPTK7QDLfvGa41GHCuPMnt90SUmrm9jRctZ8uHG760aTfmPJNnFX8yA7fCu1le084m/h7QaHcDiakcHC8mPxxmFCO4A5Iqh+AFTamd0Uyc514a93Oid7ukVeeOH1XplU10N6bw==
X-Gm-Message-State: AOJu0YzXNO5NzEkZo8G/mmlkJeTswNkS4OwafVs+vnzE1ynDLT7p5gOE
	c7YFvjlegTeOcZ5RkltgT4R74TVRnc53v2mJRx8TVLTfcXqkq+ff
X-Google-Smtp-Source: AGHT+IH7VzJXGCDOe32VGArYj3WWjM+uK6D6zRGvUlVwupXiG63LsufRSfLTk9OlRB89s+//TjHSqg==
X-Received: by 2002:a5d:598a:0:b0:343:3a4a:c7f0 with SMTP id n10-20020a5d598a000000b003433a4ac7f0mr3104848wri.12.1711795137739;
        Sat, 30 Mar 2024 03:38:57 -0700 (PDT)
Received: from gmail.com (84-236-113-97.pool.digikabel.hu. [84.236.113.97])
        by smtp.gmail.com with ESMTPSA id ch9-20020a5d5d09000000b0034330c9eccasm5714334wrb.79.2024.03.30.03.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 03:38:57 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 30 Mar 2024 11:38:55 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-trace-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, rostedt@goodmis.org,
	tony.luck@intel.com, bp@alien8.de, x86@kernel.org,
	sohil.mehta@intel.com, yazen.ghannam@amd.com
Subject: Re: [PATCH] x86/mce: Clean up TP_printk() output line of the
 mce_record tracepoint
Message-ID: <Zgfrv0NcNym681aZ@gmail.com>
References: <20240328180435.435076-1-avadhut.naik@amd.com>
 <20240328180435.435076-2-avadhut.naik@amd.com>
 <ZgZpn/zbCJWYdL5y@gmail.com>
 <93895d82-ae81-4fa3-8d58-9958d7130dcd@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93895d82-ae81-4fa3-8d58-9958d7130dcd@amd.com>


* Naik, Avadhut <avadnaik@amd.com> wrote:

> On 3/29/2024 02:11, Ingo Molnar wrote:
> > 
> > Please split out the other (capitalization) changes to the output into 
> > a separate patch.
> > 
> Okay. Will put the capitalization changes into a separate patch.
> 
> > - While at it, don't forget to:
> > 
> >    s/ADDR/MISC/SYND
> >     /addr/misc/synd
> >
> These are actually acronyms for Address, Miscellaneous and Syndrome registers.

I kept SYND capitalized in the patch:

> > +	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, addr: %016Lx, misc: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x",

But I guess ADDR and MISC are fine too.

To move forward with this I've committed the cleanup in tip:x86/cpu:

  ac5e80e94f5c x86/mce: Clean up TP_printk() output line of the 'mce_record' tracepoint

... and please post extensions of the tracepoint on top of that sane(er) code.

Thanks,

	Ingo

