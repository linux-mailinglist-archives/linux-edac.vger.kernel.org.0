Return-Path: <linux-edac+bounces-1162-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8618D56D8
	for <lists+linux-edac@lfdr.de>; Fri, 31 May 2024 02:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8262898F2
	for <lists+linux-edac@lfdr.de>; Fri, 31 May 2024 00:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4997A139E;
	Fri, 31 May 2024 00:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CsB7Gz+M"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A78A2D;
	Fri, 31 May 2024 00:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717114845; cv=none; b=qrYsf/336mjAVcRumIy2G2hfuO4i87xViFeUizHC7XrTIocBRYZStNYYN6XL7dMbUtpleM0XL/N4Npznw1MWtmWbCEbCabXM8N2ff8hk/DyNH5w0D6ezwx7aYqw6BHW31P/Re7nCJiOOGjlPtoB5wFJ8OfiZm7f7TFpVz9bKxmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717114845; c=relaxed/simple;
	bh=6eCfvSnM0YaO9SBtIYu/Zfal1XzOnsjkl0HaGq9pawI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=dOZhwPYPkvf6HKrz4oO/RjWuedo8Ltuminj6VU1CylZSo0a69kDMnwmheHFhWR54ibMGHPbHFdtYIbRwa199iV4v4e7uSuqn7udtLVtAkcRCLjYIclaIono3qxyBOEkltvGm09tseB4v2nR92mGYy5LTOeR2sZGlNLNdSW5GLE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CsB7Gz+M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UGrZdV025517;
	Fri, 31 May 2024 00:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gynQjfPIoxN/mtapgaztZK
	5d/ROaq3hN0sTXGHXwRZ4=; b=CsB7Gz+MxQ9qQLiB8oxPsLjvwEArgGaqy7ZXR/
	y2y8C56hcutEaf+9WUOvR3VqIHNENb/o+zRqPlQL6JgQPeAoRCD65YX7K918EGj0
	TY9KKnW4yiNMAmeklac/ibFiTmBkQGcIgv3ruUP8x+X52nVt2jPUdxChce1BO/PN
	PvPFa/tGg+qHix1ucPucPMFMAd4PBLDBxAzjDNydffXtrOiw1ffrezowPahwWnbL
	Y+usbYPOZNEUZstJbbl5OkA8KzPCDwdxFfdhOZ8tVtkF7MI5qg0ca3Owprys9ug2
	MpUQzC6lQkQllQm5ZoLtj3x2gMc3h4HZvRN5iessfket23GA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2pwh3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 00:20:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44V0KP64028232
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 00:20:25 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 17:20:25 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 30 May 2024 17:20:20 -0700
Subject: [PATCH] x86/mce/inject: add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240530-md-x86-mce-inject-v1-1-2a9dc998f709@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMMXWWYC/x3MQQrCMBCF4auUWTsQk6YVryJdpMloR0yUmSqB0
 rsbXX483r+BkjApnLsNhD6s/CwNx0MHcQnlRsipGayxvfHOYE5YTwPm2JZyp7iic6Ox49B7nxK
 030voyvXfvEzNc1DCWUKJy6/04PKumIOuJLDvX+Kx1/CCAAAA
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        "Thomas
 Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin"
	<hpa@zytor.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qiczb4UyaajCO-QvZnSNknv_ofnxowc7
X-Proofpoint-ORIG-GUID: qiczb4UyaajCO-QvZnSNknv_ofnxowc7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1011 bulkscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 mlxlogscore=837
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310001

make W=1 C=1 warns:
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/x86/kernel/cpu/mce/mce-inject.o

Add the missing MODULE_DESCRIPTION().

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 arch/x86/kernel/cpu/mce/inject.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 94953d749475..4ade2a3ba312 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -795,4 +795,5 @@ static void __exit inject_exit(void)
 
 module_init(inject_init);
 module_exit(inject_exit);
+MODULE_DESCRIPTION("Machine check injection support");
 MODULE_LICENSE("GPL");

---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240530-md-x86-mce-inject-3370276455dd


