Return-Path: <linux-edac+bounces-1182-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBC28FBE87
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 00:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1031F22088
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jun 2024 22:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB34143754;
	Tue,  4 Jun 2024 22:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5P1pJGD"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882351428E7;
	Tue,  4 Jun 2024 22:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539094; cv=none; b=p539wQ4IEaKzH98Bv+bGFJNhF29icxq702NLW80gfRkEcjoyeRDYsN9Pp+Gi0zSCArc9fw7djH3KC57kkBNJY8On4HgljYDumO+xt0fvWuPLfd44YeovHrCEcKL5lZp4ppXXqaH9z4oAWGIVQge6lfb6B62n3qu67hUFtnpYshc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539094; c=relaxed/simple;
	bh=0qqSJGPTBXwdLDReEi3tf3Iy9LmbcQN7JJSuQdh6qmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqoHNQ9aFh3IkzM7tiQ7fXZ873JyWTrDU1LPP954DfCTU3FxiD5L4lCpAtrf4uVv+NHmWdXn4ZiKMehStLUZP4p87o3rSdhrradjy1XxXzU8atwG5YbXXnQfVn6miN4t84WI9wdhY7gTQ8bJOyFf4pgHrMCHP43Cm4hKs2D6ohA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5P1pJGD; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52b91f655d1so299210e87.1;
        Tue, 04 Jun 2024 15:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717539091; x=1718143891; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wNcIqypllsFpryoBOPTXuwc34jW2JsHEIjMUngdWw6o=;
        b=l5P1pJGDrnJgV4zQeZGtl+y0XDMuBwacTrv8NUuPnzq7MqNeZzCfctwOiThgUdC/Xt
         6sIHWE+6//rE6l52sDK9vmol8QQuyRxboe5WvRKpdO10TRwYT2Kapb1+9ShQOk3yB0Q4
         6ipFEJ3WUz3Ca1qhOWDPY2SerDNZk94Rknfsa4ulpBaJA0Z3TshPqOCyfLRr7DYQApqv
         cQOF1sx/DnGx6Kres49/rxk4vq6BJTjwW28zrFg80pmX1QlH7RrZdtwjhlxd+2yjvDMk
         ISQkR0H3UCuw9k2S3T+1/t7FzV6SLeGLZb5u+NhUcYN4C5vBEgtMwrTwWY+bDn20xprO
         wahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717539091; x=1718143891;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNcIqypllsFpryoBOPTXuwc34jW2JsHEIjMUngdWw6o=;
        b=ILc1QIj1WyQi2FunswXy8OPfOaSuFHjBXIjF3sRnCJfeLo96LJ1SsZoR8OWnkd3XaT
         5eFU2H4TKZTQLAw6laJ5W462AWaqVHFaHxgENxFTWyVJBHSCpSspUY7fi2lfh62UDOJi
         c+Xxzkhz/TCYlBBkpq0bsPO4Q0vQJn2n4NrWp4l/uVwXeUWzUB1FZRcPwJdzG8YZY7FH
         mIQMYZvBJPst/67ZO6ej9TERXUB/EyqSROk8hSSU6uBozMOrI8oDIySmffWmL13Ur2h5
         TUihQVWJ+xjb8c/VYjzTCWi+7r37c/LuyGswhtd5mFpQ6LLGlVlAA3oRiOm+KQgY+L+4
         raSA==
X-Forwarded-Encrypted: i=1; AJvYcCXdm0aR3tI2a/Kpf1RA9CsaVH4kNVCwQqRhft3zeB8JbtokEiX8SUQBUn9CaamVhmQfZlh9pGLpDbkMbWbsa2jXvctW9fuQ4EXdjrC5N26nEXZ/Nzmx5iwz5346LAVaC6x+Kwf66hO/qg==
X-Gm-Message-State: AOJu0Yzz69toNSxFtU3+d1XHluy+n/OpDUuCuuttoujWkpWUVH4wabPr
	1RBK9/UGRHQK1J6uZX1sDGKcmCzhSgiqOHOugZAwZ8lo552SYW12ryT/CtpT
X-Google-Smtp-Source: AGHT+IF8V+Sf2LDM+fYrVEKzlj+mfwtV36fS11dhod+90QySKdOAKTpOpaIVDbKmXJxuPv1UIn6T/w==
X-Received: by 2002:a05:6512:1252:b0:52b:9635:2216 with SMTP id 2adb3069b0e04-52bab21134fmr248129e87.31.1717539090339;
        Tue, 04 Jun 2024 15:11:30 -0700 (PDT)
Received: from mobilestation ([95.79.124.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d3ebc4sm1638387e87.66.2024.06.04.15.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 15:11:29 -0700 (PDT)
Date: Wed, 5 Jun 2024 01:11:27 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Michal Simek <michal.simek@amd.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Tony Luck <tony.luck@intel.com>, 
	James Morse <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Robert Richter <rric@kernel.org>, Manish Narani <manish.narani@xilinx.com>, 
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>, Dinh Nguyen <dinguyen@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/20] EDAC/synopsys: Fix generic device type
 detection procedure
Message-ID: <5h32gfwdk6uztiv7kbsjbvbghu4yuox6h7b6pqughftztyk2yf@cmzsanqvwcmq>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
 <20240222181324.28242-3-fancer.lancer@gmail.com>
 <20240604183803.GJZl9fC9R5M2NSQ01O@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240604183803.GJZl9fC9R5M2NSQ01O@fat_crate.local>

On Tue, Jun 04, 2024 at 08:38:15PM +0200, Borislav Petkov wrote:
> On Thu, Feb 22, 2024 at 09:12:47PM +0300, Serge Semin wrote:
> > First of all the enum dev_type constants describe the memory DRAM chips
> > used at the stick, not the entire DQ-bus width (see the enumeration kdoc
> 
> Which kdoc?
> 
> The kernel doc above enum dev_type in include/linux/edac.h?

Right.

> 
> In any case, you need to be precise pls.
> 
> > for details). So what is returned from the zynqmp_get_dtype() function and
> > then specified to the dimm_info->dtype field is definitely incorrect.
> 
> Whoops, you lost me here. Why is it incorrect?

As I said because dev_type is the memory DRAM chips type (individual
DRAM chip data bus width), and not the entire DQ-bus width or its
currently active part. Even from that perspective the function name
and the subsequent return value utilization is incorrect.

Imagine the Xilinx ZynqMP has the 64-bit DQ-bus width. Having
(MSTR.data_bus_width == DDRCTL_EWDTH_16) means that only a quarter of
the bus will be utilized to get data from the DRAMs. So all the
connected DRAM chip(s) data buses are _somehow_ distributed along the
16 bits of the DRAM controller DQ-bus. It can be a single DRAM chip
with 16-bit DQ-bus, or two x8 DRAM chips, or four x4 DRAM chips, etc.

> 
> You want
> 
> "zynqmp_get_dtype - Return the controller memory width."
> 
> to return the memory width supported by the controller?
> 
> 	dimm->dtype     = p_data->get_dtype(priv->baseaddr);
> 
> 	enum dev_type dtype;    /* memory device type */
> 
> Yeah, no, that function returns the DIMM device type.
> 
> /me looks at the code.
> 
> Aha, so you mean the device width should be determined from that
> DDRC_MSTR_CFG* thing.

That's what is said in "Secondly" and "Thirdly".

> 
> > Secondly the DRAM chips type has nothing to do with the data bus width
> > specified in the MSTR.data_bus_width CSR field. That CSR field just
> > determines the part of the whole DQ-bus currently used to access the data
> > from the all DRAM memory chips. So it doesn't indicate the individual
> > chips type. Thirdly the DRAM chips type can be determined only in case of
> > the DDR4 protocol by means of the MSTR.device_config field state (it is
> 

> Hold on, this driver runs on all kinds of hardware I presume. Are you
> thinking about older ones which don't do DDR4?
> 
> Or does that thing do DDR4 only?

First of all, not that much of the kinds. Just Xilinx ZynqMP DDRC
(based on the DW uMCTL 2.40a IP-core) and some version of DW uMCTL
3.80a being possessed by Dinh Nguyen and, by a lucky coincident, turned
to be mainly compatibly with the Xilinx ZynqMP DDR controller.

Secondly I've checked that part on all the DW uMCTL2 databooks I've
got (I've got lots: versions 1.x, 2.x and 3.x). DW uMCTL2 v1.x doesn't
support DDR4. DW uMCTL2 v2.x and v3.x IP-cores do support DDR4 but
work as I described: the only way to determine the DRAM chips type is
to use the MSTR.device_config field content and for DDR4 only.
MSTR.data_bus_width field has nothing to do with that.

> 
> > supposed to be set by the system firmware).

> > Finally the DW uMCTL2 DDRC ECC
> > capability doesn't depend on the memory chips type. Moreover it doesn't
> > depend on the utilized data bus width in runtime either. The IP-core
> > reference manual says in [1,2] that the ECC support can't be enabled
> > during the IP-core synthesizes for the DRAM data bus widths other than 16,
> 
> This sentence is missing something.
> 
> > 32 or 64.  At the same time the bus width mode (MSTR.data_bus_width)
> > doesn't change the ECC feature availability. Thus it was wrong to
> > determine the ECC state with respect to the DQ-bus width mode.

Sorry, but this part doesn't miss anything. It merely says that
neither memory DRAM chips type nor MSTR.data_bus_width value could be
utilized to determine the ECC support. According to the databooks the
ECC support can be available on the IP-cores which _full_ DQ-bus width
is 16, 32 or 64. MSTR.data_bus_width, selecting the active part of the
full DQ-bus, doesn't change the ECC feature availability in anyway.
From that perspective the zynqmp_get_dtype() utilization in
zynqmp_get_ecc_state() has also been incorrect.

> 
> You need to split your paragraphs with newlines to help readability.
> Right now it is a blob of hard to parse text. For example, when you have
> to write "Secondly, " that's your split right there. "Thirdly," is your
> next newline. And so on.

Ok.

> 
> > Fix all of the mistakes described above in the zynqmp_get_dtype() and
> > zynqmp_get_ecc_state() methods: specify actual DRAM chips data width only
> > for the DDR4 protocol and return that it's UNKNOWN in the rest of the
> > cases;
> 

> What are the rest of the cases and why is it ok to return UNKNOWN all of
> a sudden? IOW, how was the old code even tested?!

First of all, MSTR.data_bus_width field can have only one of the next
three values: 0x1, 0x2 and 0x3. All of them are handled in
zynqmp_get_dtype(). So in the current (incorrect) implementation it
will never return DEV_UNKNOWN.

Secondly, dimm->dtype isn't utilized for something significant in the
EDAC subsystem, but is just exposed to the user-space via the dev_type
sysfs node.

So based on that my bet is that since the incorrect code didn't affect
the main driver functionality and since the dimm->dtype is just
exposed to user-space, the bug has been living just fine unnoticed up
until I started digging into the original DW uMCTL2 HW-manuals,
started studying the driver code, and decided to convert the driver to
supporting generic version of the DW uMCTL2 controller (not only the
Xilinx version of it). That's what this series and the next two ones
are about - about converting the driver to supporting truly generic DW
uMCTL controllers.

> 
> > determine ECC availability by the ECCCFG0.ecc_mode field state
> > only (that field can't be modified anyway if the IP-core was synthesized
> > with no ECC support).
> > 
> > [1] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
> > Databook, Version 3.91a, October 2020, p. 421.
> > [2] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
> > Databook, Version 3.91a, October 2020, p. 633.
> 
> Can those be freely accessed?
> 
> If not, you should say so.

No, they can't be.

> 
> > Fixes: b500b4a029d5 ("EDAC, synopsys: Add ECC support for ZynqMP DDR controller")
> 
> So this commit is in 4.20.
> 
> Does that mean that this fix needs to get backported to all stable
> kernels?

It's up to the stable maintainers to decide.

> 
> Have you tested this on all hw this driver supports and made sure no
> regressions are introduced?

I've tested it on the devices with DW uMCTL 2.51a + DDR3 memory and DW
uMCTL 3.10a + DDR4 memory. I am sure this will work for Xilinx ZynqMP
too, especially seeing we've already got the Shubhrajyoti Datta Rb
tag:
https://lore.kernel.org/linux-edac/CAKfKVtErVuCM+pa1e7Lwt0DUU-t-U0eNRnZSw39pfsZ8gv8QZQ@mail.gmail.com/

-Serge(y)

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

