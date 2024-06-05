Return-Path: <linux-edac+bounces-1183-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B808FC1BF
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 04:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC971C23064
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 02:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38A86BFB8;
	Wed,  5 Jun 2024 02:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Go95W800"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6C06CDAB;
	Wed,  5 Jun 2024 02:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717554137; cv=none; b=fnkUkZMsugeUtPmmWiE7ncuqYEWOiBXTdbMQVJWolBeNkGGJoAoHDml1VXg1mJmQL+KMwbglsBcvYdQnlQWyoqmCYKELCfCcEbZCibsw4jECQ9Bgkwx+pcZ2s/eMmrWBLffIwVJ0NQMllefGmvwz2+dWfjC08RfzBDGJcKhJSVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717554137; c=relaxed/simple;
	bh=AYVfxlnclM0AhGQLKjqmuvx8r+sAkmmnySMrEMRJgxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=YFTNIGTVVOdMd88l13+aKqbg+hJwQpk5NAAdcBkPkb81lHkUEswt1hQ29wcgZI2E2qxqzkiRapquhaiUZpsudirz4wqmoGj+220+NmOVhFP6FswjXp4AZX3VglFCQlii0FAfSzn7y7Acq8EaWoIYU6M/km42JG42aWz34myLlF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Go95W800; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454NWhNe004644;
	Wed, 5 Jun 2024 02:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iy8Qqx5Vp7rbVCRCTUMkKC
	vdgR7EeoiTJOrpBTvx5Ns=; b=Go95W8008pSFUab5Ye2njvcMuaChcVbg90eMRW
	IltsCPK3Q+GbUFxkKPK75DQhGjJ2p+SrOQRK5VVkCBwLQFDdVz2uskEsKv7KBAJn
	Zw3WIvKN4knYWBBACZ2aTRnTEwWUFSaHScUqqz+ZD2t0Mo2/m25Xp6w0+RYM1jQG
	fEMDfUqWNC/C9hSuhNQv0/hepDjAFj9lfyN1GcJPXWlGntVcFnPtmshRPdDAIju4
	dvRitIkr8mexVTVhV8ZGKlPHxOKZ4h6IrRnJZahhNE51qmQcfVv1/edFPOZeI3SM
	eTb3i/tjZF36MpkiOrKXlbFg+1eJTw1RDS94dJhmjR5abNPg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjauvgdvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 02:22:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4552M1pn021017
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Jun 2024 02:22:01 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Jun 2024
 19:22:00 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 4 Jun 2024 19:21:59 -0700
Subject: [PATCH] RAS/AMD/ATL: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240604-md-ras-amd-atl-v1-1-d4eb3cf3abe4@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMbLX2YC/x3MQQqDQAyF4atI1g1MB5lKr1K6iDOxBnRaElsE8
 e7Grh7f4v0bGKuwwb3ZQPknJu/quF4ayCPVF6MUN8QQ25BCi3NBJUPypWXCkIYSy60LuUvgp4/
 yIOs/+Hi6ezLGXqnm8cxMUr8rzmQLK+z7AcssPY5/AAAA
To: Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 33yaVS7EcBRhW2Fec2oFj_vVyBB6R-fw
X-Proofpoint-GUID: 33yaVS7EcBRhW2Fec2oFj_vVyBB6R-fw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 clxscore=1011 suspectscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406050017

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/ras/amd/atl/amd_atl.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/ras/amd/atl/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
index 6dc4e06305f7..7be4982fdf19 100644
--- a/drivers/ras/amd/atl/core.c
+++ b/drivers/ras/amd/atl/core.c
@@ -222,4 +222,5 @@ static void __exit amd_atl_exit(void)
 module_init(amd_atl_init);
 module_exit(amd_atl_exit);
 
+MODULE_DESCRIPTION("AMD Address Translation Library");
 MODULE_LICENSE("GPL");

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240604-md-ras-amd-atl-06fd2d780c86


