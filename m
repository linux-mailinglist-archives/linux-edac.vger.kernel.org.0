Return-Path: <linux-edac+bounces-2094-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 086529A07B7
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 12:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6591C2714A
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 10:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A2B206E84;
	Wed, 16 Oct 2024 10:46:17 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7306321E3B8;
	Wed, 16 Oct 2024 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075577; cv=none; b=mtuqnu8HAhHLBj/4DLrHKWTwW/kjplLSSeuVay0DSxoeFnXGEWpx5SCvakrLScB1hlmYkOgh62qLob99jkG99RK3LCbjhy8F53XtFk5vCfzc6jTbTYg2XDKlAg9ZwJMGeC8jJ+dX3fBlIfJuxVQr/VrY4cS5/fXNnUGJ5LT2FyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075577; c=relaxed/simple;
	bh=jO6MRbN3ZeNzo6YHbcUcHI9022JVn7wLoMMSv5ZFYEg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eRDvnpa0mE0mnQuv9T3tm/+ooCAHoF4+7WpYq3cHMWh20pSIVz8yjMr4ZRF3sjNwgrKNeHh1ze9osxAnkZWaxVZRubpKYAMUKpGHDs5prHMq+kEi0hDvtJVzLZr0aJnZG0RN5BPHvudJwp4z1AHD9o6iOlMfCF5Aj/uuwBZVa90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XT6vz38Gvz6LDLb;
	Wed, 16 Oct 2024 18:41:35 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
	by mail.maildlp.com (Postfix) with ESMTPS id 49EF9140B63;
	Wed, 16 Oct 2024 18:46:05 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 12:46:05 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 16 Oct 2024 12:46:05 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: Srinivasulu Thanneeru <sthanneeru@micron.com>, Ajay Joshi
	<ajayjoshi@micron.com>, Senthil Thangaraj <sthangaraj@micron.com>, "Vandana
 Salve" <vsalve@micron.com>
Subject: RE: [RFC PATCH] rasdaemon: Add page offline support for cxl memory
Thread-Topic: [RFC PATCH] rasdaemon: Add page offline support for cxl memory
Thread-Index: AdseIOfbJEKPvJ5+RCqFn2Wf/RSCygBjlkbw
Date: Wed, 16 Oct 2024 10:46:04 +0000
Message-ID: <9ba3aa9d658f48dbb443b36380b61f05@huawei.com>
References: <a4cdc0ddd56c450c9bfa1d950a3a37ac@micron.com>
In-Reply-To: <a4cdc0ddd56c450c9bfa1d950a3a37ac@micron.com>
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

Hi Srinivas,

Please see few comments inline,

>-----Original Message-----
>From: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>
>Sent: 14 October 2024 11:11
>To: mchehab@kernel.org; linux-edac@vger.kernel.org; linux-
>cxl@vger.kernel.org
>Cc: Srinivasulu Thanneeru <sthanneeru@micron.com>; Ajay Joshi
><ajayjoshi@micron.com>; Senthil Thangaraj <sthangaraj@micron.com>;
>Vandana Salve <vsalve@micron.com>
>Subject: [RFC PATCH] rasdaemon: Add page offline support for cxl memory
>
>From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
>
>CXL Type 3 device implements a threshold for corrected errors as described=
 in
>CXL 3.1 specification section 8.2.9.9.11.3. Device can set the threshold f=
ield in
>the DRAM event descriptor when it detects corrected errors that meet or
>exceed the threshold value.
1. Better mentioning Spec section and table for DRAM Event Record.

2. Section 8.2.9.2.1.1 Table 8-45 General Media Event Record  has threshold=
 event bit
in memory event descriptor field. May need similar page offline support for=
 General Media
Event Record too?

3. General question, Is the threshold check for the corrected errors in a C=
XL device
    always supported/enabled? If yes, please ignore following question.
    If not,
  1. Do we need to store the corrected errors reported using ras_record_pag=
e_error()
     when threshold check is not enabled?  and page would be offline when t=
he total CE count
    exceeds threshold.val by the ras-page-isolation.
      Not sure how rasdaemon get information whether threshold check is ena=
bled/supported?
      May be from Advanced Programmable Corrected Volatile Memory Error Thr=
eshold Feature?=20
>
>This patch is intended to offline pages for corrected memory errors when t=
he
>device sets the threshold in the DRAM event descriptor.
>This helps prevent corrected errors from becoming uncorrected.
>
>Record the hpa for given dpa, then do page offline for hpa when corrected
>errors threshold is set.
>
>Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
>---
> ras-cxl-handler.c    | 14 ++++++++++++++
> ras-page-isolation.c |  7 +++++++
> ras-page-isolation.h |  1 +
> ras-record.h         |  1 +
> 4 files changed, 23 insertions(+)
>
>diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c index 037c19c..c163c6f =
100644
>--- a/ras-cxl-handler.c
>+++ b/ras-cxl-handler.c
>@@ -13,6 +13,7 @@
>
> #include "ras-cxl-handler.h"
> #include "ras-logger.h"
>+#include "ras-page-isolation.h"
> #include "ras-record.h"
> #include "ras-report.h"
> #include "types.h"
>@@ -897,6 +898,12 @@ int ras_cxl_dram_event_handler(struct trace_seq *s,
> 	if (trace_seq_printf(s, "dpa:0x%llx ", (unsigned long long)ev.dpa) <=3D =
0)
> 		return -1;
>
>+	if (tep_get_field_val(s, event, "hpa", record, &val, 1) < 0)
>+		return -1;
>+	ev.hpa =3D val;
>+	if (trace_seq_printf(s, "hpa:0x%llx ", (unsigned long long)ev.hpa) <=3D =
0)
>+		return -1;
>+
Support for the new fields in cxl_general_media and cxl_dram events  includ=
ing 'hpa' had
submitted in August in the following pull request.
https://github.com/mchehab/rasdaemon/pull/178
https://github.com/mchehab/rasdaemon/pull/178/commits/0b396b47d740c88fbd890=
213f2d9d56e566e0671=20
> 	if (tep_get_field_val(s,  event, "dpa_flags", record, &val, 1) < 0)
> 		return -1;
> 	ev.dpa_flags =3D val;
>@@ -1005,6 +1012,13 @@ int ras_cxl_dram_event_handler(struct trace_seq *s,
> 		}
> 	}
>
>+#ifdef HAVE_MEMORY_CE_PFA
>+	/* Page offline for CE when threeshold is set */
>+	if (!(ev.descriptor & CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT)
>&&
>+	     (ev.descriptor & CXL_GMER_EVT_DESC_THRESHOLD_EVENT))
I think alignment should match open parenthesis.
>+		ras_hw_threshold_pageoffline(ev.hpa);
>+#endif
>+
> 	/* Insert data into the SGBD */
> #ifdef HAVE_SQLITE3
> 	ras_store_cxl_dram_event(ras, &ev);
>diff --git a/ras-page-isolation.c b/ras-page-isolation.c index bb6b777..6e=
b45d0
>100644
>--- a/ras-page-isolation.c
>+++ b/ras-page-isolation.c
>@@ -338,3 +338,10 @@ void ras_record_page_error(unsigned long long addr,
>unsigned int count, time_t t
> 		page_record(pr, count, time);
> 	}
> }
>+
>+void ras_hw_threshold_pageoffline(unsigned long long addr) {
>+	time_t now =3D time(NULL);
>+
>+	ras_record_page_error(addr, threshold.val, now); }
>diff --git a/ras-page-isolation.h b/ras-page-isolation.h index 73c9157..ed=
2f661
>100644
>--- a/ras-page-isolation.h
>+++ b/ras-page-isolation.h
>@@ -57,5 +57,6 @@ struct isolation {
> void ras_page_account_init(void);
> void ras_record_page_error(unsigned long long addr,
> 			   unsigned int count, time_t time);
>+void ras_hw_threshold_pageoffline(unsigned long long addr);
>
> #endif
>diff --git a/ras-record.h b/ras-record.h index bd861ff..d4969d1 100644
>--- a/ras-record.h
>+++ b/ras-record.h
>@@ -203,6 +203,7 @@ struct ras_cxl_general_media_event {  struct
>ras_cxl_dram_event {
> 	struct ras_cxl_event_common_hdr hdr;
> 	uint64_t dpa;
>+	uint64_t hpa;
> 	uint8_t dpa_flags;
> 	uint8_t descriptor;
> 	uint8_t type;
>--
>2.46.2
>
Thanks,
Shiju

