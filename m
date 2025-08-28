Return-Path: <linux-edac+bounces-4700-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE3DB3AA20
	for <lists+linux-edac@lfdr.de>; Thu, 28 Aug 2025 20:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9EA21897469
	for <lists+linux-edac@lfdr.de>; Thu, 28 Aug 2025 18:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625692765E9;
	Thu, 28 Aug 2025 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="UUbpN/YE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067AE2765EB;
	Thu, 28 Aug 2025 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756406387; cv=none; b=akemazPXX39mUKAy6dXbLCm5kCmrsxNFd0t8IYg/wS7orCiPnxtuFOuIGUUnQK7eVCwRVSjxt6Wo8OlPYhPb6X4GrNK1ysNXunBpXHAfQYd5xcTZrJVcAhfMyi+CAImclvSgjYsuRq3uKqHwjdYaHZ48wPPNYdi2sJ+xIKfRUxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756406387; c=relaxed/simple;
	bh=GNo2t51egNLhS8QjdRwVx/SQS8FD2wRkXa3bxmxwa4E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hT4RBFGai5MGwePgj+VDFxFfkYTr+NwJSJzlqOKpggO8tbSSQoLHU6ddBZLzyVTvX/lntfRlaZfHBZroXcMaWmg7DbSubRd3xyPr7vq4+aIQlqy8sbCSRISBFsM6Ts/8eO7SCQC7j73dtKmyvr5CDgXeLF415y7bg/SZsmhId5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=UUbpN/YE; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SEmjL4000988;
	Thu, 28 Aug 2025 18:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pps0720; bh=7tDlIM0TyZMcvSoK1xxHIEjCDRhecC3cjshhiua9X5k=; b=UUbp
	N/YEKbBZQA3HEvX3FD5d1MirTV0FjnU1H8aAlBICM677obaXSec1f8Mem5oATus7
	CjRSN3rOEdXKGuTJP5BzI09o8zDs3FCJX7D6fp/6+StpXvMyueFyVV7xmm04Kz/o
	tmM0by0ZdVVGbGwpTVgwzDqyEKvCWxJqpKK5/nuMMjn12qYK5OxybdNAtP1Hbvsj
	/aXm0wNWG8z5fQQe1w3d/uasOeZKYdhAC7AhOqRy+1jriXfWTCbsbn2tgthgyTlF
	NZru6L5KzL/3G73LNfTIAmYv+DS2aRFpmDCtjePiwFRA8xC6vsxXuCqKhMKWZ60H
	q3x3u0F5Qb2QoQVJRA==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48ts71svb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 18:38:32 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id A65F5132C5;
	Thu, 28 Aug 2025 18:38:26 +0000 (UTC)
Received: from HPE-5CG20646DK.localdomain (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 1263D800EB5;
	Thu, 28 Aug 2025 18:38:22 +0000 (UTC)
Date: Thu, 28 Aug 2025 13:38:20 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: akpm@linux-foundation.org, linmiaohe@huawei.com, jane.chu@oracle.com,
        jiaqiyan@google.com
Cc: bp@alien8.de, david@redhat.com, kyle.meyer@hpe.com,
        Liam.Howlett@oracle.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, mhocko@suse.com, nao.horiguchi@gmail.com,
        osalvador@suse.de, rppt@kernel.org, russ.anderson@hpe.com,
        surenb@google.com, tony.luck@intel.com, vbabka@suse.cz
Subject: [PATCH v2] mm/memory-failure: Fix redundant updates for already
 poisoned pages
Message-ID: <aLCiHMy12Ck3ouwC@hpe.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Authority-Analysis: v=2.4 cv=I5llRMgg c=1 sm=1 tr=0 ts=68b0a228 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8
 a=_9263MXg1XWMioqDkNYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: mEN2_SVhX1feWP9FMfdMAfO80NtjnQtM
X-Proofpoint-GUID: mEN2_SVhX1feWP9FMfdMAfO80NtjnQtM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDEyNCBTYWx0ZWRfX8D7QSBPnFi+3
 6fhGaiBbJ/Jz8Ny806+A+AhBU3IsHMWCWG/DYuWOVzwDSZM2TruWwvTX4k/yLVr7fChTslnSkvD
 YRFluNpFiUa8jj/DClEREh0I4XicCoq3nKwVLnZKIn4o+W7BGyAB+2Tlfd41zfqKWeq6cyDH7kR
 EdenwIf4aIT1pr6g/llqxD8GjrOOt1DBndGBtVh0tgQc0dbz3aFwFFP0q7YaZY31Gkhy9oHYslF
 qc1oDarTx+46ZOVri4kTCTi9yd41ir+KKpijdlDq4Buxkvn4qcOtwd0vWlMy9GTlZlHb/LAP3y4
 AWOp2klQPiNWUZooas0BOFUJW9XgduAdYNxOWGJcZ8eF00CD1bav1aFWfuPXSngKybKGxclKNTA
 ytMwq0Mq
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508280124

Duplicate memory errors can be reported by multiple sources.

Passing an already poisoned page to action_result() causes issues:

* The amount of hardware corrupted memory is incorrectly updated.
* Per NUMA node MF stats are incorrectly updated.
* Redundant "already poisoned" messages are printed.

Avoid those issues by:

* Skipping hardware corrupted memory updates for already poisoned pages.
* Skipping per NUMA node MF stats updates for already poisoned pages.
* Dropping redundant "already poisoned" messages.

Make MF_MSG_ALREADY_POISONED consistent with other action_page_types and
make calls to action_result() consistent for already poisoned
normal pages and huge pages.

Fixes: b8b9488d50b7 ("mm/memory-failure: improve memory failure action_result messages")
Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
---

v1 -> v2:
 * Continue passing poisoned pages to action_result() with MF_FAILED but don't
update anything.
 * https://lore.kernel.org/all/20250821164445.14467-1-kyle.meyer@hpe.com

---
 mm/memory-failure.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fc30ca4804bf..10b3c281c2ae 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -956,7 +956,7 @@ static const char * const action_page_types[] = {
 	[MF_MSG_BUDDY]			= "free buddy page",
 	[MF_MSG_DAX]			= "dax page",
 	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
-	[MF_MSG_ALREADY_POISONED]	= "already poisoned",
+	[MF_MSG_ALREADY_POISONED]	= "already poisoned page",
 	[MF_MSG_UNKNOWN]		= "unknown page",
 };
 
@@ -1349,9 +1349,10 @@ static int action_result(unsigned long pfn, enum mf_action_page_type type,
 {
 	trace_memory_failure_event(pfn, type, result);
 
-	num_poisoned_pages_inc(pfn);
-
-	update_per_node_mf_stats(pfn, result);
+	if (type != MF_MSG_ALREADY_POISONED) {
+		num_poisoned_pages_inc(pfn);
+		update_per_node_mf_stats(pfn, result);
+	}
 
 	pr_err("%#lx: recovery action for %s: %s\n",
 		pfn, action_page_types[type], action_name[result]);
@@ -2094,12 +2095,11 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		*hugetlb = 0;
 		return 0;
 	} else if (res == -EHWPOISON) {
-		pr_err("%#lx: already hardware poisoned\n", pfn);
 		if (flags & MF_ACTION_REQUIRED) {
 			folio = page_folio(p);
 			res = kill_accessing_process(current, folio_pfn(folio), flags);
-			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
 		}
+		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
 		return res;
 	} else if (res == -EBUSY) {
 		if (!(flags & MF_NO_RETRY)) {
@@ -2285,7 +2285,6 @@ int memory_failure(unsigned long pfn, int flags)
 		goto unlock_mutex;
 
 	if (TestSetPageHWPoison(p)) {
-		pr_err("%#lx: already hardware poisoned\n", pfn);
 		res = -EHWPOISON;
 		if (flags & MF_ACTION_REQUIRED)
 			res = kill_accessing_process(current, pfn, flags);
-- 
2.50.1


