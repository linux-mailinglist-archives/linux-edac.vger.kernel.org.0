Return-Path: <linux-edac+bounces-1341-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9DB912D66
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jun 2024 20:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1079E1C20D5E
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jun 2024 18:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623151667CF;
	Fri, 21 Jun 2024 18:45:14 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45341155CA9;
	Fri, 21 Jun 2024 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995514; cv=none; b=dUpPbApqVuve9HNqFBQcVCbjnjppNP8Mt7A6vm5nDnNCC7aDmzEJjWq1L+KV0dSL8FGDN3Hc33/5ZbBrQKE5SS4aKyk//clQeRK8eT+4XGDm/u+fDPYwrC+dWgiDdONHkN3jUtTUpFTLg4UcL2M3K/c3WbCkQg/eeWZ3QlnW/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995514; c=relaxed/simple;
	bh=5CCi7DIfeNR2GNhekl/US4v639RinnaFFSLjdAHFgb8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnZrI+wkQyhITXA8HFm06702gLVSBm1LDodFfhTKBtXBCMO0CS0aRIAbmOwZvPGhxq9sALwNtG8BgKPrQUbaXZbNqXVTCr313MAF5Pu9vucSXWiE6MIVF+n/vNzIevkv85DbY5nfabp5wsFo4TNqJnvAUjwG7MN4KZT0HtkvvrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W5R852BTsz67Gnx;
	Sat, 22 Jun 2024 02:43:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 66116140B63;
	Sat, 22 Jun 2024 02:45:08 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Jun
 2024 19:45:07 +0100
Date: Fri, 21 Jun 2024 19:45:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <ira.weiny@intel.com>,
	<alison.schofield@intel.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
	<linux-edac@vger.kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>
Subject: Re: [RFC PATCH] cxl: avoid duplicating report from MCE & device
Message-ID: <20240621194506.000024aa@Huawei.com>
In-Reply-To: <6675bf92116ed_57ac294a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
	<20240620180239.00004d41@Huawei.com>
	<6675bf92116ed_57ac294a@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 21 Jun 2024 10:59:46 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Wed, 19 Jun 2024 00:53:10 +0800
> > Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
> >   
> > > Background:
> > > Since CXL device is a memory device, while CPU consumes a poison page of 
> > > CXL device, it always triggers a MCE by interrupt (INT18), no matter 
> > > which-First path is configured.  This is the first report.  Then 
> > > currently, in FW-First path, the poison event is transferred according 
> > > to the following process: CXL device -> firmware -> OS:ACPI->APEI->GHES   
> > >  -> CPER -> trace report.  This is the second one.  These two reports    
> > > are indicating the same poisoning page, which is the so-called "duplicate
> > > report"[1].  And the memory_failure() handling I'm trying to add in
> > > OS-First path could also be another duplicate report.
> > > 
> > > Hope the flow below could make it easier to understand:
> > > CPU accesses bad memory on CXL device, then  
> > >  -> MCE (INT18), *always* report (1)
> > >  -> * FW-First (implemented now)
> > >       -> CXL device -> FW
> > > 	      -> OS:ACPI->APEI->GHES->CPER -> trace report (2.a)    
> > >     * OS-First (not implemented yet, I'm working on it)  
> > >       -> CXL device -> MSI
> > > 	      -> OS:CXL driver -> memory_failure() (2.b)    
> > > so, the (1) and (2.a/b) are duplicated.
> > > 
> > > (I didn't get response in my reply for [1] while I have to make patch to
> > > solve this problem, so please correct me if my understanding is wrong.)
> > > 
> > > This patch adds a new notifier_block and MCE_PRIO_CXL, for CXL memdev
> > > to check whether the current poison page has been reported (if yes,
> > > stop the notifier chain, won't call the following memory_failure()
> > > to report), into `x86_mce_decoder_chain`.  In this way, if the poison
> > > page already handled(recorded and reported) in (1) or (2), the other one
> > > won't duplicate the report.  The record could be clear when
> > > cxl_clear_poison() is called.
> > > 
> > > [1] https://lore.kernel.org/linux-cxl/664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> > > 
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>  
> > 
> > So poison can be cleared in a number of ways and a CXL poison clear command
> > is unfortunately only one of them.  Some architectures have instructions
> > that guarantee to write a whole cacheline and can clear things as well.
> > I believe x86 does for starters.  
> 
> Yes, movdir64b.

Equivalent arm64 instruction is not valid to normal memory. Lets say
no more on that :(

So who actually cares about recovering poisoned volatile memory?
I'd like to understand more on how significant a use case this is.
Whilst I can conjecture that its an extreme case of wanting to avoid
loosing the ability to create 1GiB or larger pages due to poison
is that a real problem for anyone today?  Note this is just the case
where you've reached an actual uncorrectable error and probably
/ possibly killed something, not the more common soft offlining
of memory due to correctable errors being detected.

> 
> > +CC linux-edac and related maintainers / reviewers.
> >     linux-mm and hwpoison maintainer.
> > 
> > So I think this needs a more general solution that encompasses 
> > more general cleanup of poison.  
> 
> I think unless the device has "List Poison" coverage for volatile ranges
> that the kernel should not worry about tracking this itself.

Maybe.  I think you can still get a media event for this as well
as synchronous poison so there may be a path to a double report, just
a more timely one hopefully.

> 
> Perhaps what is needed is that after successful memory_failure()
> handling when the page is known to be offline the device backing the
> memory can be notified that it is safe to repair the page and but it
> back into service, but I expect that would be comparison of the device's
> own poison tracking relative to the notification of successful page
> offline.

That would work. Elide the error handling if the page is known to
be offline due to poison.  Might be racey though but does it
really hurt if we occasionally report twice?

> > > +	rec = kmalloc(sizeof(struct cxl_mce_record), GFP_KERNEL);
> > > +	rec->hpa = hpa;
> > > +	list_add(&cxl_mce_records, &rec->node);
> > > +
> > > +	mutex_unlock(&cxl_mce_mutex);
> > > +
> > > +	return false;
> > > +}
> > > +
> > > +void cxl_mce_clear(u64 hpa)
> > > +{
> > > +	struct cxl_mce_record *cur, *next;
> > > +	int rc;
> > > +
> > > +	rc = mutex_lock_interruptible(&cxl_mce_mutex);  
> > 
> > Maybe cond_guard().  
> 
> cond_guard() was rejected, you meant scoped_cond_guard()? But, then I
> think _interruptible is not appropriate here.

Ah yes.  Indeed scoped_cond_guard() but fair enough on the
interruptible point!


> 


