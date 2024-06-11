Return-Path: <linux-edac+bounces-1250-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0683790420C
	for <lists+linux-edac@lfdr.de>; Tue, 11 Jun 2024 18:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D44D28DDCC
	for <lists+linux-edac@lfdr.de>; Tue, 11 Jun 2024 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD636E612;
	Tue, 11 Jun 2024 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WteRQuKz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C654F8C;
	Tue, 11 Jun 2024 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718125054; cv=none; b=HI3ZIgJSMGJVu86ekBmxbZ4dyRXn8LRlk+yYnYgwz+l1F8qzPZgVxkYrpjRc4vYEvQs0IceLzi8GLLEDI0raS16tXkxT5vKYofAg/ia0gjRjqcVA3lZI6+yHzOiTeT/peR4G8UKlSoOD5KfgQiX59KwiYl1z2l2EDHoqEDv2NZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718125054; c=relaxed/simple;
	bh=0j9xLy5Qks09hEcPhv2VnG2UIckde8Oga43oVWaqW3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCXAMqXkMJMq+1kIp+Wcbwc6wy1mNr8MWql51Ay9QwXmuk4ahiwrQeCrs9TKjPG4C9V4dRNBQIqoz0bRU7oyKyq1aUReG/Jf5VpCaS7ewtrbDqizaVt4k4giDDdcz2C2ODm4j+8PfUPYH8Ic135+Abp4nLoObWAmWIFfaWj58f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WteRQuKz; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52c8c0d73d3so3028905e87.1;
        Tue, 11 Jun 2024 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718125050; x=1718729850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fVZmCCMrY5B1OGTLHHDWkVuVsFJAPTCCeQK/T+rNRwE=;
        b=WteRQuKziXZ/k/kFJHMan/G6kjPOIpQrLnzQ3Et05jD+mebUhGH7EW8ipJ7aFP24xX
         eZAY0u6A1dSGDVwLXpn3UXyWYy97Rk8V2pqnkbZgqaDLlSt9/tqxBtR7d7swXLDw1NcH
         jlG0uy/OoDZUwPOrof7E04r6EowDKxQz+soOi3S5BqOG06ADn4e8oRgTx/KJliVDpkaf
         P1okw7BMVjmhL6u8g15pMKssGlLzN8nZJuFUippJ5IcIZPbtdRELmifSt5eij4uSKaH/
         hX3Ohqf4KVyqKrung/HGHbHmKwJzBiVXjBdsG3nbDkEARm71bXqgez4I3s10G9LbIrQl
         K6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718125050; x=1718729850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVZmCCMrY5B1OGTLHHDWkVuVsFJAPTCCeQK/T+rNRwE=;
        b=mdZKKPmnQ4HQk25a8SJfSz45Vw9NdPvgMgHETv59dgLhofOp/4kG8zeupC6tdAjAra
         iJMaZxQN5NeebYnypxZC+m40SdCPJPQ8jLLgRcm/hjOMl1qhGT68GSTwIf058YRi1Tkn
         RHJVpRQxMaJXUekdJbGaPuZ52IbFQ8b6Y0814A8kaNQ3emh13ewHenWmR/fel+bsboEr
         Pu2HQWYFRCTmQjlk/YKNODoCOYcckBCgOsxaU0YKT8MlVu2hQt3J6uwp++iH9nNM+k7I
         sfzIOxuvlFS0KI40mzhJHXhJcxxDKLPXZDGj7c7m4EUGexcQoumpY3JYHKB0FDy7nvo2
         5KYw==
X-Forwarded-Encrypted: i=1; AJvYcCXOPYtEinKX3jIB3vVwNSbbgMUo7J0JU5qM4UkjwQcA3BBReK0O53+KYkQkKXclylhMSiI5JauiziXH/CW/tYBgMNJv0B2zBuIkD/d7qlvM5MoZlT1T/oMdGDMLxDuYFVUh3H0h2LbTUA==
X-Gm-Message-State: AOJu0YxGm3NzJaPjxsd6j6Ef7wVMBsQb1bH4rFljqOat+FNyNaxql52a
	fum1yj7P2vl/RMrZCsxJMItUx7avVW8UcaOx27N+9p0WSKtl53+9
X-Google-Smtp-Source: AGHT+IHZfG9ebsXQWLg8L8GT7HK6IHZSNiflrcroHABeSVOEPCLBqVHn8B4pP0eyYRJQMV5QeCvmog==
X-Received: by 2002:a05:6512:3041:b0:52b:bdbd:2c43 with SMTP id 2adb3069b0e04-52bbdbd3144mr9127474e87.61.1718125050140;
        Tue, 11 Jun 2024 09:57:30 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c81726991sm1492536e87.220.2024.06.11.09.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 09:57:29 -0700 (PDT)
Date: Tue, 11 Jun 2024 19:57:26 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Tony Luck <tony.luck@intel.com>, 
	James Morse <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Robert Richter <rric@kernel.org>, Manish Narani <manish.narani@xilinx.com>, 
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/20] EDAC/synopsys: Fix generic device type
 detection procedure
Message-ID: <xgckna5pkrh6rgw4sz7hct6akndpewjmqzsep4lz23j6qdme33@f2y7gdqp2ihw>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
 <20240222181324.28242-3-fancer.lancer@gmail.com>
 <20240604183803.GJZl9fC9R5M2NSQ01O@fat_crate.local>
 <5h32gfwdk6uztiv7kbsjbvbghu4yuox6h7b6pqughftztyk2yf@cmzsanqvwcmq>
 <20240610080037.GFZmaypaCbTsXdGeKw@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610080037.GFZmaypaCbTsXdGeKw@fat_crate.local>

On Mon, Jun 10, 2024 at 10:00:37AM +0200, Borislav Petkov wrote:
> On Wed, Jun 05, 2024 at 01:11:27AM +0300, Serge Semin wrote:
> > As I said because dev_type is the memory DRAM chips type (individual
> > DRAM chip data bus width), and not the entire DQ-bus width or its
> > currently active part. Even from that perspective the function name
> > and the subsequent return value utilization is incorrect.
> 
> Well, maybe the author misunderstood it but the result of this goes to
> sysfs:
> 
> 	dimm->dtype     = p_data->get_dtype(priv->baseaddr);
> 
> which is in Documentation/ABI/testing/sysfs-devices-edac:
> 
> What:		/sys/devices/system/edac/mc/mc*/(dimm|rank)*/dimm_dev_type
> Date:		April 2012
> Contact:	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> 		linux-edac@vger.kernel.org
> Description:	This attribute file will display what type of DRAM device is
> 		being utilized on this DIMM (x1, x2, x4, x8, ...).
> 

> So you'd need to fix the comment above zynqmp_get_dtype() or I can do so
> too while applying.

Right. I missed the comment indeed. Thanks for spotting that. If it
won't be that much of a burden please fix it on merging the patch in.
If I need to release v7 with this patch included, then I'll fix the
comment myself. 

> 
> > First of all, not that much of the kinds.
> 
> What does that mean: "not that much of the kinds"?

The answer was following that phrase. Just two devices: ZynqMP DDRC
and a DW uMCTL v3.80a-based DDRC available on the Dinh Nguyen's
device. Seeing there were no much changes provided to the driver to
support that controller, the controller must have been compatible with
the Xilinx ZynqMP DDRC in the vast majority of the DW uMCTL2 DDRC
parameters/features.

> 
> > Just Xilinx ZynqMP DDRC (based on the DW uMCTL 2.40a IP-core) and some
> > version of DW uMCTL 3.80a being possessed by Dinh Nguyen and, by
> > a lucky coincident, turned to be mainly compatibly with the Xilinx
> > ZynqMP DDR controller.
> 
> Then Dinh better holler here what the story is.
> 
> > > > 32 or 64.  At the same time the bus width mode (MSTR.data_bus_width)
> > > > doesn't change the ECC feature availability. Thus it was wrong to
> > > > determine the ECC state with respect to the DQ-bus width mode.
> > 
> > Sorry, but this part doesn't miss anything.
> 
> Gramatically:
> 
> "The IP-core reference manual says in [1,2] that the ECC support can't
> be enabled during the IP-core synthesizes for the DRAM data bus widths
> other than 16,..."
> 
> "synthesizes" looks wrong.
> 
> It either needs to be
> 
> "... be enabled *while* the IP-core synthesizes for the DRAM..." which
> still doesn't make too much sense.
> 
> Or
> 
> "... be enabled during the IP-core *synthesis* for the DRAM..."
> 
> I don't know what you mean with that "synthesizes" thing.

But you know what it means if "synthesis" would have been utilized, right?
If no, I'll explain. If yes, then you're right. My mistake. I confused two
letters. I'll fix it in v7 should the patch need to be included there.

> 
> > First of all, MSTR.data_bus_width field can have only one of the next
> > three values: 0x1, 0x2 and 0x3. All of them are handled in
> > zynqmp_get_dtype(). So in the current (incorrect) implementation it
> > will never return DEV_UNKNOWN.
> > 
> > Secondly, dimm->dtype isn't utilized for something significant in the
> > EDAC subsystem, but is just exposed to the user-space via the dev_type
> > sysfs node.
> 
> See above.
> 
> > So based on that my bet is that since the incorrect code didn't affect
> > the main driver functionality and since the dimm->dtype is just
> > exposed to user-space, the bug has been living just fine unnoticed up
> > until I started digging into the original DW uMCTL2 HW-manuals,
> > started studying the driver code, and decided to convert the driver to
> > supporting generic version of the DW uMCTL2 controller (not only the
> > Xilinx version of it). That's what this series and the next two ones
> > are about - about converting the driver to supporting truly generic DW
> > uMCTL controllers.
> 
> I absolutely don't have a problem with that - good idea!
> 
> However, we don't break machines and don't introduce regressions.

Who would have argued.)

> 
> > > Can those be freely accessed?
> > > 
> > > If not, you should say so.
> > 
> > No, they can't be.
> 
> Then you don't need to mention them.

Well, I see it otherwise. If you posses the databook then by using the
references you can find the info there straight away with no need in
struggling through the _1.5K_ pages file. If you don't have one, then
you can just skip that part of the log.

So I'd rather leave the refs be in the log.

> 
> > 
> > > 
> > > > Fixes: b500b4a029d5 ("EDAC, synopsys: Add ECC support for ZynqMP DDR controller")
> > > 
> > > So this commit is in 4.20.
> > > 
> > > Does that mean that this fix needs to get backported to all stable
> > > kernels?
> > 
> > It's up to the stable maintainers to decide.
> 
> Haha, you're funny. How can the stable maintainers know whether each
> patch that has Fixes: tags is stable material?
> 
> Nope, that's up to the maintainer to decide.

... and the review committee, and the linux-kernel list members may
participate in the discussion too. But that's not the point here,
right?

Anyway if you wished to know my opinion, then really I don't have a
strong one in this patch regard. From one side the patch does fix an
"oh, that's not good" issue. That's why I has added the Fixes tag. On
the other hand the problem has been here unnoticed for years and
nobody cared. The only parts the incorrect method implementation has
affected was a wrong value returned to the user-space via the
sysfs-node, and the first part of the ECC-availability test procedure
which has turned to be redundant anyway since the zynqmp_get_dtype()
method never returns DEV_UNKNOWN. So my conclusion is the same. It's up
to the maintainers to decide. 

> 
> > I've tested it on the devices with DW uMCTL 2.51a + DDR3 memory and DW
> > uMCTL 3.10a + DDR4 memory. I am sure this will work for Xilinx ZynqMP
> > too, especially seeing we've already got the Shubhrajyoti Datta Rb
> > tag:
> 
> Yes, I've asked him to review that driver because this is not something
> I have or use and so on...

As you can see, I do and of two IP-core major versions (and plenty of
the DW uMCTL2 IP-core databooks). So should you need some help with
testing the bits coming for the Synopsys DW uMCTL2 EDAC driver, just
send a ping to me. I'll test them out.

-Serge(y)

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

