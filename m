Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADD96A979E
	for <lists+linux-edac@lfdr.de>; Fri,  3 Mar 2023 13:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjCCMyw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Mar 2023 07:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjCCMyv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 3 Mar 2023 07:54:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ABB2A6CE;
        Fri,  3 Mar 2023 04:54:50 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323Bv4jn017167;
        Fri, 3 Mar 2023 12:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=yy5Kfn2vWdS6a9edFGGcBMzOPeWyLFGYYQ6/QqGEfbY=;
 b=TyQDJqZYUHdqTLwU//Y0mZrOFfhOMmfAcZZHPkUWnf1qqZrCvq0EwQr+WCYZZxlOwNqQ
 ITCsWvd7YL4qW89fEZrvOhHioc28i/iP3x378rAuAIJTTqWsk/kEXbFiHIAe889TlOnR
 s7zXctIik0P9IguMzdewetE1zPDa1RCfu2GdzMRluvp0tpR/G+Jg+/Bpd/8t9JAPmdRs
 uMONo2ARPiXDqWzIf5qWGLY/ZDB2jnOR/JsO+r7oKMACDcDR1/g+pfsLSULRjQmZBa+K
 5u+vnb0dI9isFN4WbUHoLocsQ58U2O2ida3i0tk95ZwT68KvuQ0kwniqsccp0ncwdM89 eA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p3bry8yek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 12:54:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 323CsXLI009229
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 12:54:33 GMT
Received: from hu-kamasrin-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 3 Mar 2023 04:54:30 -0800
From:   Kamati Srinivas <quic_kamasrin@quicinc.com>
To:     <james.morse@arm.com>, <rric@kernel.org>, <mchehab@kernel.org>,
        <tony.luck@intel.com>, <bp@alien8.de>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_stummala@quicinc.com>,
        Kamati Srinivas <quic_kamasrin@quicinc.com>
Subject: [PATCH 0/2] edac: Add support to handle Deferred Error
Date:   Fri, 3 Mar 2023 18:24:06 +0530
Message-ID: <20230303125408.26971-1-quic_kamasrin@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pzvg-wknHCad_dC3VYg9qBCLEAyAsoQ3
X-Proofpoint-ORIG-GUID: pzvg-wknHCad_dC3VYg9qBCLEAyAsoQ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 mlxlogscore=577 spamscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030112
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patchset adds support to handle Deferred error, also
cleans up the code for log_ue/ce and corresponding APIs.

Kamati Srinivas (2):
  edac: Modify sysfs enabled values log_ue, log_ce to bool
  edac: Add support to handle DE (Deferred Errors)

 drivers/edac/edac_device.c       | 57 ++++++++++++++++++++++++++++++--
 drivers/edac/edac_device.h       | 34 +++++++++++++++++--
 drivers/edac/edac_device_sysfs.c | 50 ++++++++++++++++++++++++----
 3 files changed, 130 insertions(+), 11 deletions(-)

-- 
2.17.1

