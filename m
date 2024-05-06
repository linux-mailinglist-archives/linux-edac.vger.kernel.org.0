Return-Path: <linux-edac+bounces-1002-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5270D8BCCD1
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 13:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F7D2B20BD1
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 11:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AB4142E8B;
	Mon,  6 May 2024 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLQ1AkOh"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCC14EB2B;
	Mon,  6 May 2024 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714994877; cv=none; b=gLMg3wIDapNB61bohxVgCCg01lSgON712zq2cnmWeG4D6dYhrBcNcdj2j3V7LVCa0Et2gJ2b4EEIC68UVS5tCAuPvJp7oOqIGo7tCNJMjWOY8QdGnHynLgJYfjTnhOWLbXTz52PKK5KNcGKPL/SQD1s5qqf30QoXnaoM2esMDwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714994877; c=relaxed/simple;
	bh=TYa7LqFUn4O54qe0PJ9xUIdydNrTgl1lnBS2X3KM/9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jd7OlchbsotdMGmZ+S02NsY5algOQMAyJ4BJBrI5gu8XG2+BxEYYMS4tLcxhr4R/3AsIA926/QvygroSy4RpY/sRELYotdbCgu1m/5pheo+IGJ47fHW5Hle6pyxafsT66pnKnvCqPNDD2mYKcEyfgFlO5yn82gchSU0Nooirv88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLQ1AkOh; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51f300b318cso2124325e87.3;
        Mon, 06 May 2024 04:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714994874; x=1715599674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=98MA2KnZNukqEgivtO7pL7bJLRRsIxFS9OSQbEv7Vcs=;
        b=dLQ1AkOhPmrADYd3WsEvky0BVxGW1Ot2kD4J0bZQwfg3DEg9W54u8RGUIqntm+UdWd
         VKodVPzRG93dCiSFpZLWO9OSYau2A1Xps2VEfrGRJtpbpBM0YAVal7C+JJLJqb9t8/H+
         zfgo+HZVb3GC8aulVihksMAYGHRlmpRuIvOJk1aiRjkevbtR29zY2QiES5IOBfZU86Q1
         GMFpODmRv2N9pcHlMlrsk4hPpY//9Xey1m4OAbi/vrv8Kys/PJqcq2UB8zhDs13oMJ+t
         eFuicBfW5uDsvOYpgAUBwASx58y8wZnq7wn4smosnWCeyfmGitZNsbQg/HtS3PbPSNHF
         BOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714994874; x=1715599674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98MA2KnZNukqEgivtO7pL7bJLRRsIxFS9OSQbEv7Vcs=;
        b=vHadb66uIAYw8EF1pwh5zzJdPM0leO02WLQkTGwkDO2Bvv7hbXaTsB5azb7dt27KnI
         KIpsyInsGZACQv2S2/GCV8I+eCO1dGTK8AlJlvuNkhK6ZxAGWPkXq5rHx9fmpo7UsZB3
         3AwpPoSi4zo+PpOC+NhPqD1/FyhKvMOJt7qfsNU5y8YvmKfH6chQzhzoDNLvsNAYRPFK
         gbTj64iaYKAwCRz4E8SKeHTlWiQicLSknBo8mrWPSi0O8okmD14JkoUCVcGjLibDl7lc
         +fuB6TmfHnrxg/ihdlF7yMpIOX82P0q3bWurzPFi54oGXGu1bakIBxsLl65GQQAP5VHR
         uvKA==
X-Forwarded-Encrypted: i=1; AJvYcCU2wAfhdz9u1niMlXLLhqGMUGql8M025OfLDqA7Qbgi9akSPWti/rRry4EQgY3+xToilmJ+B3N88jMLMSZs3hE0IB0v6Sxw8MFdVW+R5VOOxqRTakt5/Kmeiid5RaRf30N6Mwqmkduqhg==
X-Gm-Message-State: AOJu0YyVNEQExgX0eMZw1p7H9U45GJWSf65EkFA0YypsvUGiMlyM+fSR
	p+l5hU4jv2+WbhbCDmhoWUfxyXv+qp0G+p3QTZkDt8gVeC2apOeX
X-Google-Smtp-Source: AGHT+IGYR9rYJo2k5OgOsPl9WSRbVSU+FeAkCa2R7Yk80NbffyS5OzCW4i9hD486JQ1D9GgaSk9DNA==
X-Received: by 2002:a05:6512:48c7:b0:51c:bf9f:ffb1 with SMTP id er7-20020a05651248c700b0051cbf9fffb1mr6070165lfb.34.1714994873758;
        Mon, 06 May 2024 04:27:53 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id bp42-20020a05651215aa00b0051f131c08c4sm1645514lfb.183.2024.05.06.04.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 04:27:53 -0700 (PDT)
Date: Mon, 6 May 2024 14:27:50 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Michal Simek <michal.simek@amd.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Tony Luck <tony.luck@intel.com>, 
	James Morse <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Robert Richter <rric@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sherry Sun <sherry.sun@nxp.com>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v5 01/20] EDAC/synopsys: Fix ECC status data and IRQ
 disable race condition
Message-ID: <vugkhnu5c7so7dk3z2cuhlbu66gv6skvicuseblrmkzyttnnlr@lqzqvysk6wbl>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
 <20240222181324.28242-2-fancer.lancer@gmail.com>
 <20240415183616.GDZh1zoFsBzvAEduRo@fat_crate.local>
 <szcie4giwjykne4su6uu5wsmtsl3e3jd53rjfiwir6hm3ju7as@6eqh2xmj35ie>
 <20240421100712.GAZiTlUOm1hrLQvaMi@fat_crate.local>
 <whgp2xx4dv3szezz3bvmgutgazz6kvie3q7rgpr35zqzuzsygk@wppqzusteru4>
 <20240506102029.GGZjiu7TKP9FVp-2Sb@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506102029.GGZjiu7TKP9FVp-2Sb@fat_crate.local>

On Mon, May 06, 2024 at 12:20:29PM +0200, Borislav Petkov wrote:
> On Thu, Apr 25, 2024 at 03:52:38PM +0300, Serge Semin wrote:
> > Even if we get to add the spin-lock serializing the ECCCLR writes it
> > won't solve the problem since the IRQ-disabler critical section could
> > be executed a bit before the IRQ-handler critical section so the later
> > one will just re-enable the IRQs disabled by the former one.
> > 
> > Here is what is suggested in my patch to fix the problem:
> > 
> >      IRQ-handler                        |    IRQ-disabler
> >                                         |
> > zynqmp_get_error_info:                  |
> >                                         | lock_irqsave
> >                                         | ECCCLR = 0; // disable IRQs
> >                                         | unlock_irqrestore
> >  lock_irqsave;                          |
> >  tmp = ECCCLR | clear_sts_bits;         |
> >  ECCCLR = tmp;                          |
> >  unlock_irqrestore;                     |
> 

> <--- I'm presuming here the IRQ-disabler will reenable interrupts at
> some point?
> 
> Otherwise we have the same problem as before when interrupts remain off
> after the IRQ handler has run.

In the sketch above the IRQ-disabler is the method which disables the
IRQ in the concurrent manner. After my patch is applied the
IRQ-handler will no longer touch the IRQ enable/disable bits, but will
preserve them as is:
-       clearval = ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT;
-       clearval |= ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
+       spin_lock_irqsave(&priv->reglock, flags);
+
+       clearval = readl(base + ECC_CLR_OFST) |
+                  ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT |
+                  ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
        writel(clearval, base + ECC_CLR_OFST);
-       writel(0x0, base + ECC_CLR_OFST);
+
+       spin_unlock_irqrestore(&priv->reglock, flags);

Thus there won't be need in the IRQs re-enabling later in the handler:

@@ -576,8 +601,6 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
        /* v3.0 of the controller does not have this register */
        if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR))
                writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
-       else
-               enable_intr(priv);

So the only IRQ-disabler left in the driver - disable_intr() - will be
called from the device/driver remove() function. The ECCCLR CSR access
will be guarded with the spin-lock in the IRQ-disabler and in the
IRQ-handler. So it will be safe to have them executed concurrently.

> 
> Other than that, yes, I see it, we will need the locking.
> 
> Thanks for elaborating.

Always welcome. Glad we've settled this.)

-Serge(y)

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

