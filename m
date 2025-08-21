Return-Path: <linux-edac+bounces-4633-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4141CB3007C
	for <lists+linux-edac@lfdr.de>; Thu, 21 Aug 2025 18:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82C1A279AD
	for <lists+linux-edac@lfdr.de>; Thu, 21 Aug 2025 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111E12E5418;
	Thu, 21 Aug 2025 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="cUSP42xE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542112E5415;
	Thu, 21 Aug 2025 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794811; cv=none; b=dXGQW1oBDfzqsiRVtc89xkH6EXh7j+ThOWH4DIF4Y2TpOj28zQcG3PP9lIca657GUXoQcZpiKiSpgnFu0AEe0s322yC7CPq5QISfskbZn4/kk30Mdx+PFgRrzkDZh25mOaLhEC8PtOan8gO9N3DhSSv58cm2W/in8fNRmetxrkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794811; c=relaxed/simple;
	bh=ujRqxGyBZMDrdRao5SiFmxd42YAaRWDp2QZB9SyY/pU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K427CkVvN5z00Ai66UQLZ39TGTKoQvhxszGdGMsGI5NBmFTkDc3BoQaRxml/aIrUKbj6R3ZSjJXcXGpV2DIVBM8RMgomrOh8FuM70wkZ91MAmGZ5wTinsceyIOla8fyd0BxoacLvsRfhBo7zpbOb0butSZ611DlVqyMaSuEnVLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=cUSP42xE; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LDWkwk032561;
	Thu, 21 Aug 2025 16:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=fUnaSevVJbXkTgu4uFDDfhr9K+M8eQzc/Tf4C
	x+wAoU=; b=cUSP42xEqwFjRXaOMpKctocd+FI7jJym7/qx2Uadv26jo5Q4yUXjV
	AsyJSMQWLlDO7HzEdRP3I42oW4s0nYBXY+ctcJ7s11drqtQYipv5y7duHeZu7XKs
	unKW+CFDAvPukAXl1U0uAqhbActnEZOZDVTcPatTeAjBWwsPZiIb1kLISFughU3R
	CjBJ668cRGGHcVdxIdo6BRI2tnDcIe2AhyiN5wRz6iiK7SKSDDvGuIPZymUha5ML
	6TvQ0H2Ig7KolGJ8eQc/rker6LOGry/zRR3LITfrGepxzHz0AMn64e+ZMdYflBvq
	XgO0nPOUu9BOM+qxkFboUEs30OyWbmd3A==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48nyktcgks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 16:46:03 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id BE8681317E;
	Thu, 21 Aug 2025 16:46:01 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 227BB806495;
	Thu, 21 Aug 2025 16:46:00 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
	id 9F9EF300A7CBA; Thu, 21 Aug 2025 11:45:59 -0500 (CDT)
From: Kyle Meyer <kyle.meyer@hpe.com>
To: akpm@linux-foundation.org, david@redhat.com, tony.luck@intel.com,
        bp@alien8.de, linmiaohe@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        nao.horiguchi@gmail.com, jane.chu@oracle.com, osalvador@suse.de,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH] mm/memory-failure: Do not call action_result() on already poisoned pages
Date: Thu, 21 Aug 2025 11:44:45 -0500
Message-Id: <20250821164445.14467-1-kyle.meyer@hpe.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDEzNyBTYWx0ZWRfX86dp1AjTaBTA
 vsn7i9VNlVA9yRA8b1YVFhpaYrGPhPzIQnvytlwiWnECD4mOv0sHCsfY5+GIV3yx+22gXDxtCFK
 9ApcUlDdssy1HrKYc99CdopWpiVNCqmulZYWZKxul1+FKILvLh0hfK1BYn7MoNLyOyR+PZIQDvm
 jXEgsc6qhrDYk37vncCTI4lEe/jgoliJYj5lWyZAV/OMBhA4qg2JQArmvHrvgFHUFr7H0x3oHCt
 YUoBfLltvwhhbourVvz8njeslmAZmHq4j5HL/ex3VW6IaI7FrGv1wIgCtrrriBVDKtR4A9r98NG
 8cNsldJ193kA4Slsbt9IgR7Qaxc+tQFOEvRiyXMnfl22ElvT5l1aYLZzELtzLSJDRZveQwUAKfG
 kXDcqAKzjv+K2T0tp1VvQ2vghQ9WN7pawdsz1PhGvdyPlj1dTGgCarVktK+Pdt+x9cYfEyyh
X-Authority-Analysis: v=2.4 cv=Ke2LcQYD c=1 sm=1 tr=0 ts=68a74d4b cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=2OwXVqhp2XgA:10 a=MvuuwTCpAAAA:8 a=t3O-YQAXfeJ1jdMRbXsA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: Q9Y7qVEh7pnZNRpL-0IN5rxEWREnYZUd
X-Proofpoint-GUID: Q9Y7qVEh7pnZNRpL-0IN5rxEWREnYZUd
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2508110000 definitions=main-2508210137

Calling action_result() on already poisoned pages causes issues:

* The amount of hardware corrupted memory is incorrectly incremented.
* NUMA node memory failure statistics are incorrectly updated.
* Redundant "already poisoned" messages are printed.

Do not call action_result() on already poisoned pages and drop unused
MF_MSG_ALREADY_POISONED.

Fixes: b8b9488d50b7 ("mm/memory-failure: improve memory failure action_result messages")
Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
---
 include/linux/mm.h      | 1 -
 include/ras/ras_event.h | 1 -
 mm/memory-failure.c     | 3 ---
 3 files changed, 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1ae97a0b8ec7..09ce81ef7afc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4005,7 +4005,6 @@ enum mf_action_page_type {
 	MF_MSG_BUDDY,
 	MF_MSG_DAX,
 	MF_MSG_UNSPLIT_THP,
-	MF_MSG_ALREADY_POISONED,
 	MF_MSG_UNKNOWN,
 };
 
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index c8cd0f00c845..f62a52f5bd81 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -374,7 +374,6 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_BUDDY, "free buddy page" )				\
 	EM ( MF_MSG_DAX, "dax page" )					\
 	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
-	EM ( MF_MSG_ALREADY_POISONED, "already poisoned" )		\
 	EMe ( MF_MSG_UNKNOWN, "unknown page" )
 
 /*
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e2e685b971bb..7839ec83bc1d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -948,7 +948,6 @@ static const char * const action_page_types[] = {
 	[MF_MSG_BUDDY]			= "free buddy page",
 	[MF_MSG_DAX]			= "dax page",
 	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
-	[MF_MSG_ALREADY_POISONED]	= "already poisoned",
 	[MF_MSG_UNKNOWN]		= "unknown page",
 };
 
@@ -2090,7 +2089,6 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		if (flags & MF_ACTION_REQUIRED) {
 			folio = page_folio(p);
 			res = kill_accessing_process(current, folio_pfn(folio), flags);
-			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
 		}
 		return res;
 	} else if (res == -EBUSY) {
@@ -2283,7 +2281,6 @@ int memory_failure(unsigned long pfn, int flags)
 			res = kill_accessing_process(current, pfn, flags);
 		if (flags & MF_COUNT_INCREASED)
 			put_page(p);
-		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
 		goto unlock_mutex;
 	}
 
-- 
2.50.1


