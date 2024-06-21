Return-Path: <linux-edac+bounces-1337-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D03B8912C5C
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jun 2024 19:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF931F22F87
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jun 2024 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA74E1607B0;
	Fri, 21 Jun 2024 17:21:11 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D9715D1;
	Fri, 21 Jun 2024 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718990471; cv=none; b=s3Aq0vzz4wf+E07k2dGny4UL1e3D0oi4jSTTQNSRX8bY4/St0NXeUtYt2zcccCiDoqLg/SIF10NqR1D3c2OXZaNurEjfIH972n1tzPR3z52aLkVFNt7dwUPIUw+MSVj1kWKd8xmWeczje/l/8eIAoOHNqb2ZBo36Q3kMSJgVc2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718990471; c=relaxed/simple;
	bh=DgcyisQOU3HS3jXqbKe/WFYgvFpfyYE3Vurt5EWfgi4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=miwMxHpv/7q1NTawBL8Akax5Uzp5e6OvN71kNX1yBBpL5/flXk13w5tpOKsOeAIQJ+RwLbNScMTMVYAgfBN7nkORI3xys2Rk3zox/R9ewWH3i5OW74TlhQGOFASji2ZKg9JAg0L9TGowqA+X03+/J9RZe85DXLuuTv+Kx51bkC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W5PJQ0PW6z6K6M8;
	Sat, 22 Jun 2024 01:20:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2740C140B38;
	Sat, 22 Jun 2024 01:21:05 +0800 (CST)
Received: from localhost (10.122.19.247) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Jun
 2024 18:21:04 +0100
Date: Fri, 21 Jun 2024 18:21:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>, <ira.weiny@intel.com>,
	<alison.schofield@intel.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, "James Morse" <james.morse@arm.com>, Mauro Carvalho
 Chehab <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
	<linux-edac@vger.kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, Naoya
 Horiguchi <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>, John Groves
	<jgroves@micron.com>
Subject: Re: [RFC PATCH] cxl: avoid duplicating report from MCE & device
Message-ID: <20240621182103.00000031@huawei.com>
In-Reply-To: <83c705ce-a013-4a88-adcd-18dbc16d88df@fujitsu.com>
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
	<20240620180239.00004d41@Huawei.com>
	<83c705ce-a013-4a88-adcd-18dbc16d88df@fujitsu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 21 Jun 2024 18:16:33 +0800
Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> =E5=9C=A8 2024/6/21 1:02, Jonathan Cameron =E5=86=99=E9=81=93:
> > On Wed, 19 Jun 2024 00:53:10 +0800
> > Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
> >  =20
> >> Background:
> >> Since CXL device is a memory device, while CPU consumes a poison page =
of
> >> CXL device, it always triggers a MCE by interrupt (INT18), no matter
> >> which-First path is configured.  This is the first report.  Then
> >> currently, in FW-First path, the poison event is transferred according
> >> to the following process: CXL device -> firmware -> OS:ACPI->APEI->GHE=
S =20
> >>   -> CPER -> trace report.  This is the second one.  These two reports=
 =20
> >> are indicating the same poisoning page, which is the so-called "duplic=
ate
> >> report"[1].  And the memory_failure() handling I'm trying to add in
> >> OS-First path could also be another duplicate report.
> >>
> >> Hope the flow below could make it easier to understand:
> >> CPU accesses bad memory on CXL device, then =20
> >>   -> MCE (INT18), *always* report (1)
> >>   -> * FW-First (implemented now)
> >>        -> CXL device -> FW
> >> 	      -> OS:ACPI->APEI->GHES->CPER -> trace report (2.a) =20
> >>      * OS-First (not implemented yet, I'm working on it) =20
> >>        -> CXL device -> MSI
> >> 	      -> OS:CXL driver -> memory_failure() (2.b) =20
> >> so, the (1) and (2.a/b) are duplicated.
> >>
> >> (I didn't get response in my reply for [1] while I have to make patch =
to
> >> solve this problem, so please correct me if my understanding is wrong.)
> >>
> >> This patch adds a new notifier_block and MCE_PRIO_CXL, for CXL memdev
> >> to check whether the current poison page has been reported (if yes,
> >> stop the notifier chain, won't call the following memory_failure()
> >> to report), into `x86_mce_decoder_chain`.  In this way, if the poison
> >> page already handled(recorded and reported) in (1) or (2), the other o=
ne
> >> won't duplicate the report.  The record could be clear when
> >> cxl_clear_poison() is called.
> >>
> >> [1] https://lore.kernel.org/linux-cxl/664d948fb86f0_e8be294f8@dwillia2=
-mobl3.amr.corp.intel.com.notmuch/
> >>
> >> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com> =20
> >=20
> > So poison can be cleared in a number of ways and a CXL poison clear com=
mand
> > is unfortunately only one of them.  Some architectures have instructions
> > that guarantee to write a whole cacheline and can clear things as well.
> > I believe x86 does for starters. =20
>=20
> According to the CXL Spec, to clear an error record on device, an=20
> explicit clear operation is required (I think this means sending a mbox=20
> command).  I'm not sure if it is able to clear device error by just=20
> writing a whole cacheline.
>=20

Please give a spec reference.  The only one I'm immediately seeing is
in 8.3.9.9.4.1 Get Poison List (opcode 43000h)
which says
"When poison is cleared"
but doesn't talk about how.

For TSP cases Clear poison is not allowed, so if they want to clear it
they will have to do it a suitable CPU arch approach not that command
(which may not be implemented in a given device - I gather it is
 awkward to do and a backdoor from control path to datapath isn't
 a popular feature!).

+CC John Groves.  John, any info you can share on whether you expect all
devices with a poison list to support the clear poison command?



> >=20
> > +CC linux-edac and related maintainers / reviewers.
> >      linux-mm and hwpoison maintainer.
> >=20
> > So I think this needs a more general solution that encompasses
> > more general cleanup of poison.
> >=20
> > Trivial comments inline. =20
>=20
> Thanks
>=20
> >=20
> > Jonathan
> >=20
> >  =20
> >> ---
> >>   arch/x86/include/asm/mce.h |   1 +
> >>   drivers/cxl/core/mbox.c    | 130 +++++++++++++++++++++++++++++++++++=
++
> >>   drivers/cxl/core/memdev.c  |   6 +-
> >>   drivers/cxl/cxlmem.h       |   3 +
> >>   4 files changed, 139 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> >> index dfd2e9699bd7..d8109c48e7d9 100644
> >> --- a/arch/x86/include/asm/mce.h
> >> +++ b/arch/x86/include/asm/mce.h
> >> @@ -182,6 +182,7 @@ enum mce_notifier_prios {
> >>   	MCE_PRIO_NFIT,
> >>   	MCE_PRIO_EXTLOG,
> >>   	MCE_PRIO_UC,
> >> +	MCE_PRIO_CXL,
> >>   	MCE_PRIO_EARLY,
> >>   	MCE_PRIO_CEC,
> >>   	MCE_PRIO_HIGHEST =3D MCE_PRIO_CEC
> >> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> >> index 2626f3fff201..0eb3c5401e81 100644
> >> --- a/drivers/cxl/core/mbox.c
> >> +++ b/drivers/cxl/core/mbox.c
> >> @@ -4,6 +4,8 @@
> >>   #include <linux/debugfs.h>
> >>   #include <linux/ktime.h>
> >>   #include <linux/mutex.h>
> >> +#include <linux/notifier.h>
> >> +#include <asm/mce.h>
> >>   #include <asm/unaligned.h>
> >>   #include <cxlpci.h>
> >>   #include <cxlmem.h>
> >> @@ -880,6 +882,9 @@ void cxl_event_trace_record(const struct cxl_memde=
v *cxlmd,
> >>   		if (cxlr)
> >>   			hpa =3D cxl_trace_hpa(cxlr, cxlmd, dpa);
> >>  =20
> >> +		if (hpa !=3D ULLONG_MAX && cxl_mce_recorded(hpa))
> >> +			return;
> >> +
> >>   		if (event_type =3D=3D CXL_CPER_EVENT_GEN_MEDIA)
> >>   			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
> >>   						&evt->gen_media);
> >> @@ -1408,6 +1413,127 @@ int cxl_poison_state_init(struct cxl_memdev_st=
ate *mds)
> >>   }
> >>   EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
> >>  =20
> >> +struct cxl_mce_record {
> >> +	struct list_head node;
> >> +	u64 hpa;
> >> +};
> >> +LIST_HEAD(cxl_mce_records);
> >> +DEFINE_MUTEX(cxl_mce_mutex);
> >> +
> >> +bool cxl_mce_recorded(u64 hpa)
> >> +{
> >> +	struct cxl_mce_record *cur, *next, *rec;
> >> +	int rc;
> >> +
> >> +	rc =3D mutex_lock_interruptible(&cxl_mce_mutex); =20
> >=20
> > guard(mutex)(&cxl_mce_muted);
> >  =20
> >> +	if (rc)
> >> +		return false;
> >> +
> >> +	list_for_each_entry_safe(cur, next, &cxl_mce_records, node) {
> >> +		if (cur->hpa =3D=3D hpa) {
> >> +			mutex_unlock(&cxl_mce_mutex);
> >> +			return true;
> >> +		}
> >> +	}
> >> +
> >> +	rec =3D kmalloc(sizeof(struct cxl_mce_record), GFP_KERNEL);
> >> +	rec->hpa =3D hpa;
> >> +	list_add(&cxl_mce_records, &rec->node);
> >> +
> >> +	mutex_unlock(&cxl_mce_mutex);
> >> +
> >> +	return false;
> >> +}
> >> +
> >> +void cxl_mce_clear(u64 hpa)
> >> +{
> >> +	struct cxl_mce_record *cur, *next;
> >> +	int rc;
> >> +
> >> +	rc =3D mutex_lock_interruptible(&cxl_mce_mutex); =20
> >=20
> > Maybe cond_guard(). =20
>=20
> Ok, this is better.  I'll use automatic clean locks instead.
>=20
>=20
> --
> Thanks,
> Ruan.
>=20
> >  =20
> >> +	if (rc)
> >> +		return;
> >> +
> >> +	list_for_each_entry_safe(cur, next, &cxl_mce_records, node) {
> >> +		if (cur->hpa =3D=3D hpa) {
> >> +			list_del(&cur->node);
> >> +			break;
> >> +		}
> >> +	}
> >> +
> >> +	mutex_unlock(&cxl_mce_mutex);
> >> +}
> >> +
> >> +struct cxl_contains_hpa_context {
> >> +	bool contains;
> >> +	u64 hpa;
> >> +};
> >> +
> >> +static int __cxl_contains_hpa(struct device *dev, void *arg)
> >> +{
> >> +	struct cxl_contains_hpa_context *ctx =3D arg;
> >> +	struct cxl_endpoint_decoder *cxled;
> >> +	struct range *range;
> >> +	u64 hpa =3D ctx->hpa;
> >> +
> >> +	if (!is_endpoint_decoder(dev))
> >> +		return 0;
> >> +
> >> +	cxled =3D to_cxl_endpoint_decoder(dev);
> >> +	range =3D &cxled->cxld.hpa_range;
> >> +
> >> +	if (range->start <=3D hpa && hpa <=3D range->end) {
> >> +		ctx->contains =3D true;
> >> +		return 1;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static bool cxl_contains_hpa(const struct cxl_memdev *cxlmd, u64 hpa)
> >> +{
> >> +	struct cxl_contains_hpa_context ctx =3D {
> >> +		.contains =3D false,
> >> +		.hpa =3D hpa,
> >> +	};
> >> +	struct cxl_port *port;
> >> +
> >> +	port =3D cxlmd->endpoint;
> >> +	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port=
))
> >> +		device_for_each_child(&port->dev, &ctx, __cxl_contains_hpa);
> >> +
> >> +	return ctx.contains;
> >> +}
> >> +
> >> +static int cxl_handle_mce(struct notifier_block *nb, unsigned long va=
l,
> >> +			  void *data)
> >> +{
> >> +	struct mce *mce =3D (struct mce *)data;
> >> +	struct cxl_memdev_state *mds =3D container_of(nb, struct cxl_memdev_=
state,
> >> +						    mce_notifier);
> >> +	u64 hpa;
> >> +
> >> +	if (!mce || !mce_usable_address(mce))
> >> +		return NOTIFY_DONE;
> >> +
> >> +	hpa =3D mce->addr & MCI_ADDR_PHYSADDR;
> >> +
> >> +	/* Check if the PFN is located on this CXL device */
> >> +	if (!pfn_valid(hpa >> PAGE_SHIFT) &&
> >> +	    !cxl_contains_hpa(mds->cxlds.cxlmd, hpa))
> >> +		return NOTIFY_DONE;
> >> +
> >> +	/*
> >> +	 * Search PFN in the cxl_mce_records, if already exists, don't conti=
nue
> >> +	 * to do memory_failure() to avoid a poison address being reported
> >> +	 * more than once.
> >> +	 */
> >> +	if (cxl_mce_recorded(hpa))
> >> +		return NOTIFY_STOP;
> >> +	else
> >> +		return NOTIFY_OK;
> >> +}
> >> +
> >>   struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
> >>   {
> >>   	struct cxl_memdev_state *mds;
> >> @@ -1427,6 +1553,10 @@ struct cxl_memdev_state *cxl_memdev_state_creat=
e(struct device *dev)
> >>   	mds->ram_perf.qos_class =3D CXL_QOS_CLASS_INVALID;
> >>   	mds->pmem_perf.qos_class =3D CXL_QOS_CLASS_INVALID;
> >>  =20
> >> +	mds->mce_notifier.notifier_call =3D cxl_handle_mce;
> >> +	mds->mce_notifier.priority =3D MCE_PRIO_CXL;
> >> +	mce_register_decode_chain(&mds->mce_notifier);
> >> +
> >>   	return mds;
> >>   }
> >>   EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, CXL);
> >> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> >> index 0277726afd04..aa3ac89d17be 100644
> >> --- a/drivers/cxl/core/memdev.c
> >> +++ b/drivers/cxl/core/memdev.c
> >> @@ -376,10 +376,14 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u=
64 dpa)
> >>   		goto out;
> >>  =20
> >>   	cxlr =3D cxl_dpa_to_region(cxlmd, dpa);
> >> -	if (cxlr)
> >> +	if (cxlr) {
> >> +		u64 hpa =3D cxl_trace_hpa(cxlr, cxlmd, dpa);
> >> +
> >> +		cxl_mce_clear(hpa);
> >>   		dev_warn_once(mds->cxlds.dev,
> >>   			      "poison clear dpa:%#llx region: %s\n", dpa,
> >>   			      dev_name(&cxlr->dev));
> >> +	}
> >>  =20
> >>   	record =3D (struct cxl_poison_record) {
> >>   		.address =3D cpu_to_le64(dpa),
> >> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> >> index 19aba81cdf13..fbf8d9f46984 100644
> >> --- a/drivers/cxl/cxlmem.h
> >> +++ b/drivers/cxl/cxlmem.h
> >> @@ -501,6 +501,7 @@ struct cxl_memdev_state {
> >>   	struct cxl_fw_state fw;
> >>  =20
> >>   	struct rcuwait mbox_wait;
> >> +	struct notifier_block mce_notifier;
> >>   	int (*mbox_send)(struct cxl_memdev_state *mds,
> >>   			 struct cxl_mbox_cmd *cmd);
> >>   };
> >> @@ -836,6 +837,8 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u=
64 offset, u64 len,
> >>   int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
> >>   int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
> >>   int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
> >> +bool cxl_mce_recorded(u64 pfn);
> >> +void cxl_mce_clear(u64 pfn);
> >>  =20
> >>   #ifdef CONFIG_CXL_SUSPEND
> >>   void cxl_mem_active_inc(void); =20
> >  =20


