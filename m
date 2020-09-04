Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E5025DB37
	for <lists+linux-edac@lfdr.de>; Fri,  4 Sep 2020 16:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgIDOSq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Sep 2020 10:18:46 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:2141 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730523AbgIDNne (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 4 Sep 2020 09:43:34 -0400
IronPort-SDR: DM3MuquYRSRq9WbnLzUQSo84yh/zNWWXi7R52buaJt0mNdADGqYp/8UTOUjmKaxWhM1BZh/GYb
 NqXMgqBRtJz0EEZeePQszqSozGjvMN8IFd1jyiRCroG3+0hb5Y0K6NOo+B0p8e7XYl+Dboudh/
 XGN/iL4VdivQvCnw/xNNyaSgWa49RWyUiK3kUWUSqZK9grt2IGpkU7geqwgG6dtbcnDW498FUR
 3xUo7kqdJi09fJU/ASvLcRLpc+cDTMGJKX3YGcNh+DJ/ar1/jxDyEWAj/4x3/Ehteie/lBDjMp
 LVQ=
X-IronPort-AV: E=Sophos;i="5.76,389,1592863200"; 
   d="scan'208";a="13736690"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 Sep 2020 15:32:59 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 04 Sep 2020 15:32:59 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 04 Sep 2020 15:32:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1599226379; x=1630762379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tokluGbsiNNI7Hd85q03H4j+c/JJNOvxxnlL27i1dPw=;
  b=TnAiY36c5ipMBKmcr+3u7XNns514JENQdHIZv3bDd9yvCoEXy9+kKT0V
   tOge1Bug+9KGFaGgjV00FausmH+t9Kpqd3HF3Sv2/xX2WAGDTIQKQuCvr
   tDsuAkKYpuRm9nAU8cUZdiIFib3dqWhBR+tTRS5NWhEb8E1A9iu0ZV6zp
   0ICW9baWs8lOYsX3/Hje7Y1hBw72uAQC+iU07qFKD9BQbQ3EDfhiBmKMW
   mPke8W/mwzclVMFJk3XMdHFppmqSX1ZxNrzYwHD7nkqp39UN78N8r3mTE
   8g1JECxnO2bFMDd20b4Om4sG6q6u6NFgrFvPP11CXM3hKdZduvK3AHZb+
   A==;
IronPort-SDR: cZroEdyxCxno1ipoxac5Wbf2T1rxUymibbQcfithDemXdqhayuIpUPPbX/ugZOONlw0HggiSFH
 iQXZ8f33ET0eALJGcmOnukIbhjojKvuQWLegbk7q7pW15oEguzEh1yL71+p5kdcVuErfo1x3Uh
 ZmVG3Y/WDWtY9+3YV83Sdv2UP1kVku6kASwn57lQoiQy+LwQ1ZLXiaD1IOQRFDSv4HJRgrcdP+
 XtlayloYc4+TgDcTJB/yTVcZKmaTIsZCwDNoQ8AkZNVwqFX+D3mxKn4sCI7/iQNrU3TWHTXqpf
 Fjw=
X-IronPort-AV: E=Sophos;i="5.76,389,1592863200"; 
   d="scan'208";a="13736689"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Sep 2020 15:32:59 +0200
Received: from herburgerg-w.tq-net.de (herburgerg-w.tq-net.de [10.122.52.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 1F69C280065;
        Fri,  4 Sep 2020 15:32:59 +0200 (CEST)
Date:   Fri, 4 Sep 2020 15:32:58 +0200
From:   Gregor Herburger <gregor.herburger@ew.tq-group.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "york.sun@nxp.com" <york.sun@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregor.herburger@ew.tq-group.com
Subject: Re: [PATCH v2 1/1] edac: fsl_ddr_edac: fix expected data message
Message-ID: <20200904133258.GA21716@herburgerg-w.tq-net.de>
References: <kcEE.e0qfoTd8SOOr3lTVWaXz/A.AASg8YeC1gE@vtuxmail01.tq-net.de>
 <20200904091718.GC21499@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200904091718.GC21499@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Sep 04, 2020 at 11:17:18AM +0200, Borislav Petkov wrote:
> Your mail client broke threading...
> 
Indeed. Guess I have to change the mail client. Sorry for that.
> On Fri, Sep 04, 2020 at 06:52:24AM +0000, Gregor Herburger wrote:
> 
> > The cap_low, cap_high and syndrome are used in the printk following the if-Block.
> > This will make expected data / captured data look the same.
> 
> Right.
> 
> > @@ -334,18 +337,32 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
> >                 sbe_ecc_decode(cap_high, cap_low, syndrome,
> >                                 &bad_data_bit, &bad_ecc_bit);
> > 
> > +               exp_high = cap_high;
> > +               exp_low = cap_low;
> > +               exp_syndrome = syndrome;
> > +
> >                 if (bad_data_bit != -1)
> > +               {
> 
> Opening brace is on the same line for if-statements.
> 
> >                         fsl_mc_printk(mci, KERN_ERR,
> >                                 "Faulty Data bit: %d\n", bad_data_bit);
> > +
> > +                       if (bad_data_bit < 32)
> > +                               exp_low = cap_low ^ (1 << bad_data_bit);
> > +                       else
> > +                               exp_high = cap_high ^ (1 << (bad_data_bit - 32));
> > +               }
> > +
> >                 if (bad_ecc_bit != -1)
> > +               {
> 
> Ditto.
> 
> >                         fsl_mc_printk(mci, KERN_ERR,
> >                                 "Faulty ECC bit: %d\n", bad_ecc_bit);
> > 
> > +                       exp_syndrome = syndrome ^ (1 << bad_ecc_bit);
> > +               }
> > +
> >                 fsl_mc_printk(mci, KERN_ERR,
> >                         "Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
> > -                       cap_high ^ (1 << (bad_data_bit - 32)),
> > -                       cap_low ^ (1 << bad_data_bit),
> > -                       syndrome ^ (1 << bad_ecc_bit));
> > +                       exp_high, exp_low, exp_syndrome);
> >         }
> > 
> >           fsl_mc_printk(mci, KERN_ERR,
> >                           "Captured Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
> >                           cap_high, cap_low, syndrome);
> > 
> > How about something like this?
> 
> My only concern here is that you'll be printing "Expected Data ..."
> unconditionally even if either or both - bad_data_bit and bad_ecc_bit
> - are -1.
That shouldn't happen. The whole if-block is only executed when a single 
bit correctable error has occured (DDR_EDE_SBE). So we always should have
bad_data_bit or bad_ecc_bit (exclusively).

> 
> If the driver cannot decode the data and/or ECC syndrome bits, then it
> should say so - not dump expected data and claim that it is a valid
> information.
> 
Ok, that is reaonable. But that shouldn't that go into sbe_ecc_decode()?.
Currently sbe_ecc_decude() returns on the first error it finds. So we would
have to rework this function.

> So maybe in addition to the above:
> 
> 	if (bad_data_bit != -1) {
> 		...
> 	} else {
> 		fsl_mc_printk(..., "Unable to decode the Faulty Data bit");
> 	}
> 
> and the same for the ECC bit.
> 
I suggest adding such an message to sbe_ecc_decode(). Also to add an
return 0 on success and to check that before printing infos about single
bit errors.

> And then print only the expected data for the bit which sbe_ecc_decode()
> found correctly and not say anything otherwise.
> 
Also i just noticed in the kernel log is no hint that this is an
single bit error. Maybe we should add this too?
