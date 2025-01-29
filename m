Return-Path: <linux-edac+bounces-2954-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E98A21D19
	for <lists+linux-edac@lfdr.de>; Wed, 29 Jan 2025 13:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF37918855CE
	for <lists+linux-edac@lfdr.de>; Wed, 29 Jan 2025 12:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850811DA0E0;
	Wed, 29 Jan 2025 12:28:18 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B86855887;
	Wed, 29 Jan 2025 12:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738153698; cv=none; b=BHQwgG9ah8lOCRvi48nLdlyoodZnCw2DiP2UWq3RHrHoSPmXhJ95MxpCr7mOAT99wiLpVJAvW/14Pclrsg9vPm5ZQZ3/G39FvXxKC7kH/iseWuQ4N4zssXZqYH2d/qK7pvGqwCwRcK78eveo1PHzhbmYToe2KuXLvEXpkjgcook=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738153698; c=relaxed/simple;
	bh=Gj+ibSeI7rkt/86HKoaTaKC0GPhl2/i0gFiRNXig2L8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PZ6oBtu4mG1EhAvqf7yVax6TUVN98TUMlgCCBT3HEIVhJYWofyFLmi8rhowMgLvS8cCD5iSSmMYtsOFsautsoO5uN9P87CabXndtf41oJ30TpiU/Dj8HDSCX8Zcvw/rxL8T1EKcOOSM9PCtZGfJXhvqiAUG7d3I0i5oHz9E4hso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YjhG56mK7z6M4V7;
	Wed, 29 Jan 2025 20:26:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5329C140B30;
	Wed, 29 Jan 2025 20:28:11 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 Jan 2025 13:28:11 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 29 Jan 2025 13:28:11 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "dave@stgolabs.net" <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v18 15/19] cxl/memfeature: Add CXL memory device patrol
 scrub control feature
Thread-Topic: [PATCH v18 15/19] cxl/memfeature: Add CXL memory device patrol
 scrub control feature
Thread-Index: AQHbYDQzwb2+msEnKkOZzkWMDvDlzLMmbr6AgAQZmTCAAMm+AIACfVPQ
Date: Wed, 29 Jan 2025 12:28:10 +0000
Message-ID: <6b897863e04e4e588f1af318e4292739@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <20250106121017.1620-16-shiju.jose@huawei.com>
 <6793fa5351fc7_20f3294d0@dwillia2-xfh.jf.intel.com.notmuch>
 <637fa0190fe64594954ee4d9e012c39c@huawei.com>
 <679814068d4d1_2d1e294c4@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <679814068d4d1_2d1e294c4@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>-----Original Message-----
>From: Dan Williams <dan.j.williams@intel.com>
>Sent: 27 January 2025 23:17
>To: Shiju Jose <shiju.jose@huawei.com>; Dan Williams
><dan.j.williams@intel.com>; linux-edac@vger.kernel.org; linux-
>cxl@vger.kernel.org; linux-acpi@vger.kernel.org; linux-mm@kvack.org; linux=
-
>kernel@vger.kernel.org
>Cc: bp@alien8.de; tony.luck@intel.com; rafael@kernel.org; lenb@kernel.org;
>mchehab@kernel.org; dave@stgolabs.net; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>david@redhat.com; Vilas.Sridharan@amd.com; leo.duran@amd.com;
>Yazen.Ghannam@amd.com; rientjes@google.com; jiaqiyan@google.com;
>Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
>naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
>somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
>duenwen@google.com; gthelen@google.com;
>wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Roberto
>Sassu <roberto.sassu@huawei.com>; kangkang.shen@futurewei.com;
>wanghuiqiang <wanghuiqiang@huawei.com>; Linuxarm
><linuxarm@huawei.com>
>Subject: RE: [PATCH v18 15/19] cxl/memfeature: Add CXL memory device patro=
l
>scrub control feature
>
>Shiju Jose wrote:
>> Hi Dan,
>>
>> Thanks for the comments.
>>
>> Please find reply inline.
>>
>> Thanks,
>> Shiju
>> >-----Original Message-----
>> >From: Dan Williams <dan.j.williams@intel.com>
>> >Sent: 24 January 2025 20:39
>> >To: Shiju Jose <shiju.jose@huawei.com>; linux-edac@vger.kernel.org;
>> >linux- cxl@vger.kernel.org; linux-acpi@vger.kernel.org;
>> >linux-mm@kvack.org; linux- kernel@vger.kernel.org
>> >Cc: bp@alien8.de; tony.luck@intel.com; rafael@kernel.org;
>> >lenb@kernel.org; mchehab@kernel.org; dan.j.williams@intel.com;
>> >dave@stgolabs.net; Jonathan Cameron <jonathan.cameron@huawei.com>;
>> >dave.jiang@intel.com; alison.schofield@intel.com;
>> >vishal.l.verma@intel.com; ira.weiny@intel.com; david@redhat.com;
>> >Vilas.Sridharan@amd.com; leo.duran@amd.com;
>Yazen.Ghannam@amd.com;
>> >rientjes@google.com; jiaqiyan@google.com; Jon.Grimm@amd.com;
>> >dave.hansen@linux.intel.com; naoya.horiguchi@nec.com;
>> >james.morse@arm.com; jthoughton@google.com;
>somasundaram.a@hpe.com;
>> >erdemaktas@google.com; pgonda@google.com; duenwen@google.com;
>> >gthelen@google.com; wschwartz@amperecomputing.com;
>> >dferguson@amperecomputing.com; wbs@os.amperecomputing.com;
>> >nifan.cxl@gmail.com; tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
>> ><prime.zeng@hisilicon.com>; Roberto Sassu <roberto.sassu@huawei.com>;
>> >kangkang.shen@futurewei.com; wanghuiqiang
><wanghuiqiang@huawei.com>;
>> >Linuxarm <linuxarm@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
>> >Subject: Re: [PATCH v18 15/19] cxl/memfeature: Add CXL memory device
>> >patrol scrub control feature
>> >
>> >shiju.jose@ wrote:
>> >> From: Shiju Jose <shiju.jose@huawei.com>
>> >>
>> >> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub
>> >> control feature. The device patrol scrub proactively locates and
>> >> makes corrections to errors in regular cycle.
>> >>
>> >> Allow specifying the number of hours within which the patrol scrub
>> >> must be completed, subject to minimum and maximum limits reported
>> >> by the
>> >device.
>> >> Also allow disabling scrub allowing trade-off error rates against
>> >> performance.
>> >>
>> >> Add support for patrol scrub control on CXL memory devices.
>> >> Register with the EDAC device driver, which retrieves the scrub
>> >> attribute descriptors from EDAC scrub and exposes the sysfs scrub
>> >> control attributes to userspace. For example, scrub control for the
>> >> CXL memory device "cxl_mem0" is exposed in
>> >/sys/bus/edac/devices/cxl_mem0/scrubX/.
>> >>
>> >> Additionally, add support for region-based CXL memory patrol scrub
>control.
>> >> CXL memory regions may be interleaved across one or more CXL memory
>> >> devices. For example, region-based scrub control for "cxl_region1"
>> >> is exposed in /sys/bus/edac/devices/cxl_region1/scrubX/.
>> >>
>> >> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> >> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> >> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> >> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> >> ---
>> >>  Documentation/edac/scrub.rst  |  66 ++++++
>> >>  drivers/cxl/Kconfig           |  17 ++
>> >>  drivers/cxl/core/Makefile     |   1 +
>> >>  drivers/cxl/core/memfeature.c | 392
>> >++++++++++++++++++++++++++++++++++
>> >>  drivers/cxl/core/region.c     |   6 +
>> >>  drivers/cxl/cxlmem.h          |   7 +
>> >>  drivers/cxl/mem.c             |   5 +
>> >>  include/cxl/features.h        |  16 ++
>> >>  8 files changed, 510 insertions(+)  create mode 100644
>> >> drivers/cxl/core/memfeature.c diff --git
>> >> a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst index
>> >> f86645c7f0af..80e986c57885 100644
>> >> --- a/Documentation/edac/scrub.rst
>> >> +++ b/Documentation/edac/scrub.rst
>[..]
>> >
>> >What is this content-free blob of cat and echo statements? Please
>> >write actual documentation with theory of operation, clarification of
>> >assumptions, rationale for defaults, guidance on changing defaults...
>>
>> Jonathan already replied.
>
>I disagree that any of that is useful to include without rationale, and if=
 the
>rationale is already somewhere else then delete the multiple lines of show=
ing
>how 'cat' and 'echo' work with sysfs.
I will discuss with Jonathan on this how to modify.=20

>
>[..]
>> >> +	depends on CXL_MEM
>> >
>> >Similar comment, and this also goes away if all of this just moves
>> >into the new cxl_features driver.
>>
>> Agree with  Jonathan told in reply. These are RAS specific features
>> for CXL memory devices and thus added in memfeature.c
>
>Apoligies for this comment, I had meant to delete it along with some other
>commentary along this theme after thinking it through.
>
>I am now advocating that Dave drop his cxl_features driver altogether and
>mirror your approach. I.e. EDAC is registered from existing CXL drivers, a=
nd
>FWCTL can be registered against a cxl_memdev just like the fw_upload ABI.
>
>There was a concern that CXL needed a separate FWCTL driver in case
>distributions wanted to have a policy against FWCTL, but given CXL already=
 has
>CONFIG_CXL_MEM_RAW_COMMANDS at compile-time and a wide array of CXL
>bus devices, a cxl_features device is an awkward fit.
Ok.=20
>
>[..]
>> >> +static int cxl_ps_get_attrs(struct cxl_patrol_scrub_context *cxl_ps_=
ctx,
>> >> +			    struct cxl_memdev_ps_params *params) {
>> >> +	struct cxl_memdev *cxlmd;
>> >> +	u16 min_scrub_cycle =3D 0;
>> >> +	int i, ret;
>> >> +
>> >> +	if (cxl_ps_ctx->cxlr) {
>> >> +		struct cxl_region *cxlr =3D cxl_ps_ctx->cxlr;
>> >> +		struct cxl_region_params *p =3D &cxlr->params;
>> >> +
>> >> +		for (i =3D p->interleave_ways - 1; i >=3D 0; i--) {
>> >> +			struct cxl_endpoint_decoder *cxled =3D p->targets[i];
>> >
>> >It looks like this is called directly as a callback from EDAC. Where
>> >is the locking that keeps cxl_ps_ctx->cxlr valid, or p->targets content=
 stable?
>> Jonathan already replied.
>
>I could not find that comment? I *think* it's ok because when the region i=
s in the
>probe state changes will not be made to this list, but it would be useful =
to at
>least have commentary to that effect. Protect against someone copying this
>code in isolation and not consider the context.
Sure. Will do.
>
>[..]
>> >> +
>> >> +int cxl_mem_ras_features_init(struct cxl_memdev *cxlmd, struct
>> >> +cxl_region *cxlr)
>> >
>> >Please separate this into a memdev helper and a region helper. It is
>> >silly to have two arguments to a function where one is expected to be
>> >NULL at all times, and then have an if else statement inside that to
>> >effectively turn it back into 2 code paths.
>> >
>> >If there is code to be shared amongst those, make *that* the shared hel=
per.
>> I added single function cxl_mem_ras_features_init() for both memdev
>> and region based scrubbing to reduce code size as there were feedbacks t=
ry
>reduce code size.
>
>"Succint" and "concise" does not necessarily mean less lines. I would grea=
tly
>prefer a few more lines if it mines not outsourcing complexity to the call=
ing
>context. Readable code means I do not need to wonder
>what:
>
>   cxl_mem_ras_features_init(NULL, cxlr)
>
>...means. I can just read devm_cxl_region_edac_register(cxlr), and know ex=
actly
>what is happening without needing to lose my train of thought to go read w=
hat
>semantics cxl_mem_ras_features_init() is implementing.
>
>Note that all the other _init() calls in drivers/cxl/ (outside of module_i=
nit
>callbacks), are just purely init work, not object registration. Please kee=
p that
>local style.
Sure. Will add  separate functions for region based edac registration.
>
>> >> +{
>> >> +	struct edac_dev_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
>> >> +	char cxl_dev_name[CXL_DEV_NAME_LEN];
>> >> +	int num_ras_features =3D 0;
>> >> +	u8 scrub_inst =3D 0;
>> >> +	int rc;
>> >> +
>> >> +	rc =3D cxl_memdev_scrub_init(cxlmd, cxlr,
>> >&ras_features[num_ras_features],
>> >> +				   scrub_inst);
>> >> +	if (rc < 0)
>> >> +		return rc;
>> >> +
>> >> +	scrub_inst++;
>> >> +	num_ras_features++;
>> >> +
>> >> +	if (cxlr)
>> >> +		snprintf(cxl_dev_name, sizeof(cxl_dev_name),
>> >> +			 "cxl_region%d", cxlr->id);
>> >
>> >Why not pass dev_name(&cxlr->dev) directly?
>> Jonathan already replied.
>
>That was purely with the cxl_mem observation, cxlr can be passed directly.
Will check.
>
>> >
>> >> +	else
>> >> +		snprintf(cxl_dev_name, sizeof(cxl_dev_name),
>> >> +			 "%s_%s", "cxl", dev_name(&cxlmd->dev));
>> >
>> >Can a "cxl" directory be created so that the raw name can be used?
>
>In fact we already do something similar for CONFIG_HMEM_REPORTING (i.e.
>an "access%d" device to create a nameed directory of attributes) so it is =
a
>question for Boris if he wants to tolerate a parent "cxl" device to parent=
 all CXL
>objects in EDAC.
>
>> >
>> >> +
>> >> +	return edac_dev_register(&cxlmd->dev, cxl_dev_name, NULL,
>> >> +				 num_ras_features, ras_features);
>> >
>> >I'm so confused... a few lines down in this patch we have:
>> >
>> >    rc =3D cxl_mem_ras_features_init(NULL, cxlr);
>> >
>> >...so how can this call to edac_dev_register() unconditionally
>> >de-reference @cxlmd?
>> Thanks for spotting this. It is a bug, need to fix.
>
>
>[..]
>> >> +EXPORT_SYMBOL_NS_GPL(cxl_mem_ras_features_init, "CXL");
>> >> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> >> index b98b1ccffd1c..c2be70cd87f8 100644
>> >> --- a/drivers/cxl/core/region.c
>> >> +++ b/drivers/cxl/core/region.c
>> >> @@ -3449,6 +3449,12 @@ static int cxl_region_probe(struct device *dev=
)
>> >>  					p->res->start, p->res->end, cxlr,
>> >>  					is_system_ram) > 0)
>> >>  			return 0;
>> >> +
>> >> +		rc =3D cxl_mem_ras_features_init(NULL, cxlr);
>> >> +		if (rc)
>> >> +			dev_warn(&cxlr->dev, "CXL RAS features init for
>> >region_id=3D%d failed\n",
>> >> +				 cxlr->id);
>> >
>> >There is more to RAS than EDAC memory scrub so this message is
>> >misleading. It is also unnecessary because the driver continues to
>> >load and the admin, if they care, will notice that the EDAC attributes =
are
>missing.
>> This message was added for the debugging purpose in CXL driver. I will c=
hange
>to  dev_dbg().
>
>...but also stop calling this functionality with the blanket term "RAS".
>It is "EDAC scrub and repair extensions to all the other RAS functionality=
 the CXL
>subsystem handles directly", name it accordingly.
Sure. Will change.

Thanks,
Shiju


