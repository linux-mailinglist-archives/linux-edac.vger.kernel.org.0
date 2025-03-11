Return-Path: <linux-edac+bounces-3346-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5860A5BA93
	for <lists+linux-edac@lfdr.de>; Tue, 11 Mar 2025 09:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487AC16BD68
	for <lists+linux-edac@lfdr.de>; Tue, 11 Mar 2025 08:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F3F225760;
	Tue, 11 Mar 2025 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZhEst07"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA10224247
	for <linux-edac@vger.kernel.org>; Tue, 11 Mar 2025 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680782; cv=none; b=bBOV0fDzHKN4cfDszE7O+SP1Mjoqpfv65vUp2SE97kDvuh2EnknoHkGlR0SOJCb+BML4Ik5LXg1hBTtt2oHCKTREUyIZw/RfVBU/CYoY2sWZasOmdPgDGh2HXkAmH/nqsGhvLsjpPX6emXG67wuJXUYcJgFb9y0TRlO9BRos5k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680782; c=relaxed/simple;
	bh=TH0u9dVGvoVbZ7K3UqXVA55ShQn2kghUIl5g3rDHr+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HossSDtJpt9meDoNeYjLGmiFIJ4LqK9S88ZVz+9wjCm6VX8KKp7r5mYGVxS5jDh6deYIt6OT3q27OACyrYrJBNXQ7LAne03EusfGYPvp4ZWA5e45qL/bVgc6YtH44A8fcZPqkgmLkuGt2vG2BFSfr1jyg1ubKPaa3MDvCRcfnCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eZhEst07; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39133f709f5so1898241f8f.0
        for <linux-edac@vger.kernel.org>; Tue, 11 Mar 2025 01:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741680779; x=1742285579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d9hUC77ttL7VpNgoPVtZetc+bIdsy8nR0pbNY/lEgyQ=;
        b=eZhEst07rhV5kf5u7dj+6dCOlS1nDnM3V/ElrLDm+/DrYl4UmNOF6oR2L/b3hGcdJA
         nHUr3kZUjTzlg/TR90tUYe8qWkff/MSDbm6L8ztivZCTa/0DEy4ehSXg18MDL7StLgPd
         CWnt42erkYgYzlrwWmpccQlvE4bSVM+QvIhJ8Ku9pCRKPF/rEPMsCrWE2L4lMmWknfXZ
         45YjXKBZA20jQte7GxWh5G2RuqhFgmFPeDVC1fQvmYLoZpRr+hAYCOfc8MaqNcY3XbHo
         VnBKHSS9eR+h/5VKb64bR0NXHk09B9803zaJ2lrTxggqC9xYzcLLEviMMZqGIQljvYO0
         Ypdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741680779; x=1742285579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9hUC77ttL7VpNgoPVtZetc+bIdsy8nR0pbNY/lEgyQ=;
        b=IVwE4BCcpwyqF52sv9WCAaU+XyjhuHkQsaap8CS8xsOgay/qxCSIMtfOn9DbN/uwIG
         zfQKnMHz+eFMN94904fF6kVOySpHwoQdBSr11t+aU8TU1LcdbZLwTFuDFswWdaFUG2ze
         MKdksHLt0P+gYra+2IzUC28tIGbPl9a1PYnfEqQqD6FoOmfTellHJokuE31YWOWMH5gA
         CA7W2gBP+sIvwx/U5RsQP7gSg4KSCZ37nHa+nAlvz/X3I9C94EbTH0d36dOK9nJPrr0M
         OhwRZ5QJkXD5vOQpTLxZsh1uDISwsfbuv3HIRz/oaGQu574LMJqxMDoh8vgGHaEQJ8uy
         tNkA==
X-Forwarded-Encrypted: i=1; AJvYcCU30Xj5wJDNRcYiFQDdhjrOfLNSgzFV4tJ57x13nk5hTgLzhfUMoXZKl+UFc9/r5khsJfAbHQaUCSBX@vger.kernel.org
X-Gm-Message-State: AOJu0YwNIQhQ5pTZiGqgsIP8QbOk9/Jy42NAm/bB56FMWlLii2J9lQnJ
	cgwWP33ZtTKKYqIY6JNxw0qg4QuqzQVfDRKTMLu9MDzc9kJFiryH9JCbaEdnq6o=
X-Gm-Gg: ASbGnct5HoVue7WlTrW43eC7HsC6v14USAIX8jysr0hw2OmcaG1wyBkaEe59Porgr8D
	pgXfwumBMSZqiUAWVGfKnUq9CA9rl6PSPb0LML4UdnwqJKpDLWaWt6YP8b/+MBPRFv0yJsysoHN
	lXZZYiHPxNDVirXo/MA+9AzLaxNkJc5wuxYX+QcV1zz7Z9eUfxcB3BoBZlTPKVgfIVNE2+XrYvj
	LjsaV3aZMTZMU5jULD/dMRGWw5cQdEtFf9zuk3f22MrlARvFGF8o2pb1tz+q28fWAmz65iagsk6
	WaP1hrwNj2VmEA7JAKRFwRWk4SdWdGb2zM4VQRfLim5Jrc8Jhg==
X-Google-Smtp-Source: AGHT+IHQe5urwt2Q3djRRAmzur7elKU2h0pqAZvz5+2zIbJd7QEmn7pPxhLZABGxMIFRNedH3+9Dqg==
X-Received: by 2002:adf:9b9d:0:b0:391:3b11:d604 with SMTP id ffacd0b85a97d-3913b11d767mr6992628f8f.54.1741680778874;
        Tue, 11 Mar 2025 01:12:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912c0195bfsm17215168f8f.48.2025.03.11.01.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:12:58 -0700 (PDT)
Date: Tue, 11 Mar 2025 11:12:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Thompson <davthompson@nvidia.com>
Cc: Borislav Petkov <bp@alien8.de>, Shravan Ramani <shravankr@nvidia.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] EDAC, mellanox: Add ECC support for BlueField DDR4
Message-ID: <7c58ba57-96ff-4d9b-a014-dfe3fc0c44b5@stanley.mountain>
References: <046bf689-9a2b-4993-b8ca-927d7d2a0cc5@stanley.mountain>
 <20250303145226.GCZ8XCKkC0YSLHXycB@fat_crate.local>
 <PH7PR12MB590225F9E7C1BA48B5EF538AC7D12@PH7PR12MB5902.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR12MB590225F9E7C1BA48B5EF538AC7D12@PH7PR12MB5902.namprd12.prod.outlook.com>

On Tue, Mar 11, 2025 at 02:22:20AM +0000, David Thompson wrote:
> > -----Original Message-----
> > From: Borislav Petkov <bp@alien8.de>
> > Sent: Monday, March 3, 2025 9:52 AM
> > To: Dan Carpenter <dan.carpenter@linaro.org>; David Thompson
> > <davthompson@nvidia.com>
> > Cc: Shravan Ramani <sramani@mellanox.com>; linux-edac@vger.kernel.org; lkml
> > <linux-kernel@vger.kernel.org>
> > Subject: Re: [bug report] EDAC, mellanox: Add ECC support for BlueField DDR4
> > 
> > On Thu, Oct 24, 2024 at 11:20:45AM +0300, Dan Carpenter wrote:
> > > Hello Shravan Kumar Ramani,
> > >
> > > Commit 82413e562ea6 ("EDAC, mellanox: Add ECC support for BlueField
> > > DDR4") from Jun 25, 2019 (linux-next), leads to the following Smatch
> > > static checker warning:
> > >
> > > drivers/edac/bluefield_edac.c:205 bluefield_gather_report_ecc() error:
> > uninitialized symbol 'dram_syndrom'.
> > > drivers/edac/bluefield_edac.c:219 bluefield_gather_report_ecc() error:
> > uninitialized symbol 'dram_additional_info'.
> > > drivers/edac/bluefield_edac.c:231 bluefield_gather_report_ecc() error:
> > uninitialized symbol 'edea0'.
> > > drivers/edac/bluefield_edac.c:231 bluefield_gather_report_ecc() error:
> > uninitialized symbol 'edea1'.
> > > drivers/edac/bluefield_edac.c:256 bluefield_edac_check() error: uninitialized
> > symbol 'ecc_count'.
> > >
> > > drivers/edac/bluefield_edac.c
> > >     173 static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
> > >     174                                         int error_cnt,
> > >     175                                         int is_single_ecc)
> > >     176 {
> > >     177         struct bluefield_edac_priv *priv = mci->pvt_info;
> > >     178         u32 dram_additional_info, err_prank, edea0, edea1;
> > >     179         u32 ecc_latch_select, dram_syndrom, serr, derr, syndrom;
> > >     180         enum hw_event_mc_err_type ecc_type;
> > >     181         u64 ecc_dimm_addr;
> > >     182         int ecc_dimm, err;
> > >     183
> > >     184         ecc_type = is_single_ecc ? HW_EVENT_ERR_CORRECTED :
> > >     185                                    HW_EVENT_ERR_UNCORRECTED;
> > >     186
> > >     187         /*
> > >     188          * Tell the External Memory Interface to populate the relevant
> > >     189          * registers with information about the last ECC error occurrence.
> > >     190          */
> > >     191         ecc_latch_select = MLXBF_ECC_LATCH_SEL__START;
> > >     192         err = bluefield_edac_writel(priv, MLXBF_ECC_LATCH_SEL,
> > ecc_latch_select);
> > >     193         if (err)
> > >     194                 dev_err(priv->dev, "ECC latch select write failed.\n");
> > >     195
> > >     196         /*
> > >     197          * Verify that the ECC reported info in the registers is of the
> > >     198          * same type as the one asked to report. If not, just report the
> > >     199          * error without the detailed information.
> > >     200          */
> > >     201         err = bluefield_edac_readl(priv, MLXBF_SYNDROM,
> > &dram_syndrom);
> > >     202         if (err)
> > >     203                 dev_err(priv->dev, "DRAM syndrom read failed.\n");
> > >
> > > If bluefield_edac_readl() fails then dram_syndrom is uninitialized.
> > >
> > >     204
> > > --> 205         serr = FIELD_GET(MLXBF_SYNDROM__SERR, dram_syndrom);
> > >     206         derr = FIELD_GET(MLXBF_SYNDROM__DERR, dram_syndrom);
> > >     207         syndrom = FIELD_GET(MLXBF_SYNDROM__SYN, dram_syndrom);
> > >
> > 
> > This looks forgotten.
> > 
> > I'm thinking of:
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8e0736dc2ee0..061149ade8c0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8222,8 +8222,7 @@ F:
> > 	Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> >  F:	drivers/edac/aspeed_edac.c
> > 
> >  EDAC-BLUEFIELD
> > -M:	Shravan Kumar Ramani <shravankr@nvidia.com>
> > -S:	Supported
> > +S:	Orphan
> >  F:	drivers/edac/bluefield_edac.c
> > 
> >  EDAC-CALXEDA
> > 
> > but lemme Cc people who have touched this recently first.
> > 
> > Thx.
> > 
> > --
> > Regards/Gruss,
> >     Boris.
> > 
> > https://people.kernel.org/tglx/notes-about-netiquette
> 
> Shravan and I will investigate solving this 'smatch' warning.
> 
> I setup a recent linux-next repo, installed the sparse package, and downloaded + built the smatch tool.  
> I execute the following command to run 'smatch' over the entire linux kernel, including bluefield_edac.c:
>    $ make CHECK="/path/to/smatch -p=kernel --file-output" C=1 -j64
> 
> I don't see any warnings related to the bluefield_edac.c module. That is, the generated file 
> "drivers/edac/bluefield_edac.c.smatch" has size 0, and thus no content.
> 
> What is the recommended command line options to pass to Linux kernel build?
> Is there something I am missing here?

The actual issue is the first "return -1" in secure_readl().

You need build the cross function database to see the warning in Smatch.
In fact you'd need to build it twice because it's two functions away.
It's not hard to build the database but it takes a few hours.

~/progs/smatch/release/smatch_scripts/build_kernel_data.sh

I wouldn't bother trying to silence the warning.  We don't worry about
false positives.  The only thing to consider is the kernel code.

Probably bluefield_edac_readl() can't actually fail in real life can
it?  There are a lot of functions like that in the kernel.  If reading
from the PCI stops working, there is nothing you can do in the software
to recover from that, you need to buy new hardware.  If you want I can
just add bluefield_edac_readl() to the list of functions which don't
actually fail.

regards,
dan carpenter

