Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 122D216BD73
	for <lists+linux-edac@lfdr.de>; Tue, 25 Feb 2020 10:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgBYJjZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Feb 2020 04:39:25 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:53884 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729080AbgBYJjY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 25 Feb 2020 04:39:24 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01P9XlkP023687;
        Tue, 25 Feb 2020 01:39:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=+fu/PYyltrhjTtl98xceuto/ct1lP3k3zkzgM/xTJFU=;
 b=UpcW9K21tnUV9FIT7Q4Na95JEqigneRqYXv03WD2I6lGdSlng5nd74MDZHzXRfbxKf3O
 QKMtaw1ZLuo4r4XotDkzx5o6pzlubtb+cwsimf0xSJV3YCIOmAvp5Z9/nRw/zQOzGQ7a
 GKdb0B/qUpbNiKxHcaytJoAhbD/+u5MD4eJ0PJwPLSM9PICyJNdg1Z9UzmyFSbL1i8v8
 UcSR6nNg5bZOLQXSZnUR3woMZEWkWqqfvO+UdRu1zK7vnAF4P9qSvDTfViW42n+7Ecrt
 YD0/7O/57kbO7koAQdHGKKq+QW4UDALqacT9nBhHY1asPn5IcqOn7LawTr+oNr1Ht38Z ag== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2054.outbound.protection.outlook.com [104.47.44.54])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2yb0s3tx3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 01:39:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmETDWH5E8hAIYatHNvu/CbciBA1jAS7Db/rSU9IoxZuDDn8ID10O6oMR99+bMroAjFftveyb4Nvrbvlfzn5EI7VOvsdkL+ty9J0sV9fFKVonhL4ua3GMaY9GhyLAJBM0wJyTBv2p6MypUJ4JCFhWDiZ5JWHmPb20ydhjE8aSeZJAUEmcyOYn4Hhrms/tBHrIb83m+JGhZf7wBkMkoVYVBtP9iMwre+gGXjvt3U2k+3zFW7En+EC7dsKFCUrAq3pqtRhSHdDub4TBVl+QygpoJ7KHS1/r20mRcL5/6Nvxh6LATnFByz3WfjwafMA1n7E6cfFy11a1Oc9uflT/tapDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fu/PYyltrhjTtl98xceuto/ct1lP3k3zkzgM/xTJFU=;
 b=bmvJRI13Mmh+8vPq1nHSVH34ZKezQDJlkq9VxMFCbr4i3p9oYn2DapWbSNDxYrgqFhmFboeQQDPgC57eqhIljR7qVHk4vgNMG9WGtad11m+y1niIwpURGVg0YJUGHkTmci0wuSAYFlkoH8C7kcFav3YKTFVE6Yc+rdH8YDV1RcEVgmLun9j/HiJ++37ouh+GgRYIXi2uVKjPpXq2AeVve1hwI3k6R4QYkqThrC87lcAxCC8ZOr6nVCOyb1oo0xbMANlQmelgdAkoB3I7M2NidLHEOhMx2AG1xDKKlXZnn7H6b96s2H7y4y6E3mQV0pHSSvtGSZEs4D9UMnm1Hl/ocQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fu/PYyltrhjTtl98xceuto/ct1lP3k3zkzgM/xTJFU=;
 b=YF33xohG2YGnY4GHyZrsdHS+ahOZajMImcRZrrLYjWYsHPfoH21AFa6ttEl6vN30HirOhwk04YfRX6FzSAWCu6NRw+H4PyR3LtrKUPxqpXgrpOgrOyPSgKFN0OkjAYHcfzjxIs3arvOsBtOt+50+xyBax0h6E5/MhgBqFwvLb4U=
Received: from DM6PR02CA0051.namprd02.prod.outlook.com (2603:10b6:5:177::28)
 by MWHPR0701MB3674.namprd07.prod.outlook.com (2603:10b6:301:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 09:39:06 +0000
Received: from DM6NAM12FT045.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::dc) by DM6PR02CA0051.outlook.office365.com
 (2603:10b6:5:177::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Tue, 25 Feb 2020 09:39:06 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 DM6NAM12FT045.mail.protection.outlook.com (10.13.178.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.6 via Frontend Transport; Tue, 25 Feb 2020 09:39:06 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 01P9d2qS127657
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 01:39:05 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 25 Feb 2020 10:39:01 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 25 Feb 2020 10:39:01 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 01P9d1VM007379;
        Tue, 25 Feb 2020 10:39:01 +0100
Received: (from dkangude@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 01P9d1Hp007377;
        Tue, 25 Feb 2020 10:39:01 +0100
From:   Dhananjay Kangude <dkangude@cadence.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Dhananjay Kangude <dkangude@cadence.com>
Subject: [PATCH 0/2] Add EDAC support for Cadence ddr controller
Date:   Tue, 25 Feb 2020 10:38:54 +0100
Message-ID: <20200225093856.7328-1-dkangude@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(189003)(199004)(36092001)(70206006)(4744005)(356004)(70586007)(426003)(4326008)(336012)(186003)(36906005)(2616005)(316002)(1076003)(478600001)(6916009)(54906003)(5660300002)(2906002)(6666004)(86362001)(8936002)(81156014)(81166006)(36756003)(26005)(42186006)(107886003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3674;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8165b9c-ef8f-4acb-3a16-08d7b9d68e93
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3674:
X-Microsoft-Antispam-PRVS: <MWHPR0701MB36743C80151BE6C92C49EC0ECDED0@MWHPR0701MB3674.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0324C2C0E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQm9GJlTeng/6SdO7MPufD6i2EGx22w1bHVtHrpUSnmAkHgrjjY3iVdr0RpQH55h9wXDr3Mzxr/tPYBVnVfhOwG7HLtPfLYcZ78t2edQjXpqV7cGcDOTKzcm6GLpEkXItdQ1pLei2MPFVB6cYy8bK6kc2ZPiSSXjttszjDZ7o3pu42sbuUnyWBa135kVYOZ5M4jeqCXw2WN4dM3iwvpwCXWWB0/COJsjlIXokbo3KOHSouKXKXAfv88e+XZCn7lN/nFvyG/UToSTnEXwgXOmx1qERtOEvuriAhXeX9EA07PmFP0mIc7pA8mZNess3WoRZTast/EFYnnRj/EOHFv2Y+XPPC1xfintWMTpPwevLK5tlxRGZC+WeZyT59wDe8GyIOaD/TuS8vMKbgvpnFWrH5QtH5Ap+4OG5GEUPcgq2i4bH1Phs9H/Mod+nBZicUzyQ6T1d8bKsdvnRvC4/lsBf0z+imlwUXBvxFxPTEAo2ZmYevWV8Nrq+TVuOHd86Rya
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 09:39:06.1198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8165b9c-ef8f-4acb-3a16-08d7b9d68e93
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3674
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_02:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 suspectscore=1 clxscore=1015 lowpriorityscore=0 mlxlogscore=539
 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250078
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


These patches add new edac driver for Cadence ddr memory controller.
Cadence controller detects single(CE) and double(UE) bit errors during
memory operations(RMW). DDR controller raised the interrupt on detection
of the ecc error event and fill the data into registers. Driver handle
the interrupt event and notify edac subsystem about ecc errors.

The patch series has two patches:
1. Add driver support into edac subsystem
2. Add devicetree binding in yaml format

Dhananjay Kangude (2):
  EDAC/Cadence:Add EDAC driver for cadence memory controller
  dt-bindings: edac: Add cadence ddr mc support

 .../devicetree/bindings/edac/cdns,ddr-edac.yaml    |   56 ++
 drivers/edac/Kconfig                               |    7 +
 drivers/edac/Makefile                              |    1 +
 drivers/edac/cadence_edac.c                        |  615 ++++++++++++++++++++
 4 files changed, 679 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
 create mode 100644 drivers/edac/cadence_edac.c

