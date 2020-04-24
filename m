Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77831B6FC2
	for <lists+linux-edac@lfdr.de>; Fri, 24 Apr 2020 10:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgDXIcT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 24 Apr 2020 04:32:19 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:24444 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbgDXIcS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 24 Apr 2020 04:32:18 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03O8R6dF010824;
        Fri, 24 Apr 2020 01:32:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=BhUKxukAAqs/hBZIN/jlfK4WHXj82zKcM57sjBsAtqQ=;
 b=oSNqxk0yP2puuQtxy8fcDYicMEeldeIxkoAArWdQbtPKS8UQo9/ElS6bQQr2Ih4l2isj
 7mK8xOyCNpWLZvIk7vKKB25wf0GZIcSiKzlkxlUa3iCWGvSguT75ZKhMtx4L0LcW6WmD
 dl44nagrAmBvHBrzszK1CbBjbuFWV5hWQvpXKBbuyDNVSK80vQeN24ONu/F6Rwb1LtL/
 Nxz7UUYDAGXTtDglunFhJioe2/bchQAJs8cEbbqvudtLpGWRbfwYvkUGom90/iFgq7IN
 n9+OiKvDBFMPvgSLUHUEvy7187yvj5ER1zmOe9i9pftl2y0aZGHU8dy2TpFNLyvL+Pvg Xw== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2053.outbound.protection.outlook.com [104.47.38.53])
        by mx0a-0014ca01.pphosted.com with ESMTP id 30fx3v1842-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 01:32:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQXUWQKJ6rmq3YXa9W20KX6WrkE0HmMWCdSKz3yVPEBLjS/JABSvynrspG5I9mncR8QAk6K/WtkvA1jd+u5eG05mxTo8xPafdn+mQA/3JNh3eql/GewFpwEIkDq4YY3xcc14+Ntf56BaW+BekHw9WopiXR+5bAcM0M02QndoXcCXy1IM4bJa/eF6SAwhJWCuW244LjfVKKzsHTNqNjtY+DHoRWazBt+J/xAPE0e40saEr4DAarTL+I6cUun9B5q9DVcOnvZvaqZ4QlXNd6k/43/T6Ao2hvdavQlZLp7mBPLoP5Da2kD6I5wpEO2hm0fOHqS4k0/SsLVM5w2NV/TywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhUKxukAAqs/hBZIN/jlfK4WHXj82zKcM57sjBsAtqQ=;
 b=STZgeZFJOOrohhYHV55bQQ/BH35bJImUFZZ1+MYu5PT6uxugbuqppemBMe5I5wehX6oErhtA+ZE132fK3DSTylJx6xLvhUzIg5YEBLuH+HPoFwVfhEG18swSMNT7S5mN8mgdTK2iLMdQs+2/73E/R2jdGIRUuEBH+01l2CDpS/B3SxtLTvaaMrtDw/BO3TDumKf68KAR1b0mRPPAND9OOU6OQULqIlhG0dKNvXnfXJKTX3Pq16ULf3QYWX5NlXPB9Ryzh+MiOHFvkL+MkrUPFkb9C6B59pj7qop6AkQbtQHNM3yKaQY3wT/xylvaIH6y/lNgzncwTFM/XLrmGb6+cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhUKxukAAqs/hBZIN/jlfK4WHXj82zKcM57sjBsAtqQ=;
 b=C10+v2trei+SE+GujSonA5xfOGKjHub1c29v1Hv2oXcJwd3zzX3kSt0BQc8T/Ighi9JIh2OIee9ex42gtt9n2ClKKSay0FF0bUEql2gA4kpAwRDw3KypjiHLZdFFZmoqwpVHOy5YgmqnzFRrLHwHlqapR2O29AFUv/vASregiKg=
Received: from BN8PR04CA0052.namprd04.prod.outlook.com (2603:10b6:408:d4::26)
 by DM6PR07MB4393.namprd07.prod.outlook.com (2603:10b6:5:cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Fri, 24 Apr
 2020 08:32:04 +0000
Received: from BN8NAM12FT048.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::39) by BN8PR04CA0052.outlook.office365.com
 (2603:10b6:408:d4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 08:32:04 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT048.mail.protection.outlook.com (10.13.182.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.12 via Frontend Transport; Fri, 24 Apr 2020 08:32:03 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 03O8W0s7029879
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 24 Apr 2020 01:32:01 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 24 Apr 2020 10:31:59 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 24 Apr 2020 10:31:59 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 03O8VxR1031006;
        Fri, 24 Apr 2020 10:31:59 +0200
Received: (from dkangude@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 03O8Vw5s031001;
        Fri, 24 Apr 2020 10:31:58 +0200
From:   Dhananjay Kangude <dkangude@cadence.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Dhananjay Kangude <dkangude@cadence.com>
Subject: [PATCH v4 0/2] Add EDAC support for Cadence ddr controller
Date:   Fri, 24 Apr 2020 10:31:53 +0200
Message-ID: <20200424083155.30918-1-dkangude@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(39860400002)(36092001)(46966005)(36756003)(5660300002)(336012)(47076004)(7636003)(86362001)(82740400003)(246002)(6916009)(426003)(6666004)(70586007)(36906005)(2906002)(8936002)(478600001)(82310400002)(42186006)(316002)(8676002)(70206006)(2616005)(26005)(54906003)(107886003)(186003)(4326008)(1076003)(356005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c664b6a7-550c-4c7e-3a37-08d7e829f71d
X-MS-TrafficTypeDiagnostic: DM6PR07MB4393:
X-Microsoft-Antispam-PRVS: <DM6PR07MB43938AA39F4E5801974C58B7CDD00@DM6PR07MB4393.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03838E948C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9tp4YM3jD6CTgJK7Q3YRZG+2jnTT3hUnWvYOUmE+7nXysC/7v3MmSj14K4I4sbbGLEjr4dKXCafQvVMfHy8fkrSpFleNUTinSs86N9Dd5gIxBEg3IOp+gASxQhn4hHD8lyl1EOkBaqJY28uYLza2Ym7Aor1AH/1IfvWluUurw33835BoGq0Mz/ACxPeZdOpA06D01rAvzZ4clPozT8lX6Ubsg9bBqgoEAzU7n5TIW/rr/KsWB4g6w7pRKwJnIU2mA6G/bdDsuMobug9lBUI0Qh8AL2/cDCndbuBbnkFda9GVxgslfHwUUkmxc3r3B2eM6VkLkVoo8XqT+2fXZ/fuEbKrzX9hGLVPfMRjyIqHm6HtD8L36sC9bd6n8NgNWLd92j9cchWk2rS+/UxIvEQzqcMcyQsPblqqKuYh95pgIXzGcNV/b/0YKqOjJdh/7S15NSl1cBm4GmOipx8Oq7ut7Mc/0wp/0z8x0EI3ZfdcYdX6HUkz9/R9gpX0zP+TllOR81nAJPxDbe/zLjx09yQ0pLBad8qqCpPSekNA0XidEoc=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 08:32:03.2026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c664b6a7-550c-4c7e-3a37-08d7e829f71d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4393
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_02:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=1 bulkscore=0 mlxlogscore=671 mlxscore=0
 clxscore=1015 impostorscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004240066
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

These patches add new edac driver for Cadence ddr memory controller.
Cadence controller detects single(CE) and double(UE) bit errors during
memory operations(RMW). DDR controller raised the interrupt on detection
of the ecc error event and fill the data into registers. Driver handle
the interrupt event and notify edac subsystem about ecc errors.

Changes since v4:
=================
- Add Makefile change
- Coreected YAML file fixes

Changes since v3:
=================
- Corrected YAML file location

Changes since v2:
=================
- Added minor fixes to YAML file
- Split ISR into two differnt functions
- Removed unused paramters
- Fixed indentation issues
- Improved code readabilty
- Checked return value for edac_get_dimm
- Modified quirks as a ip_features

Changes since v1:
=================
- Made predefined arrays as static
  Fixes: 201447a5db9b ("EDAC/Cadence:Add EDAC driver for cadence memory controller")
- Replace macro 'EDAC_DIMM_PTR' with newly introduce function
- Removed unused variable root*** SUBJECT HERE ***

Dhananjay Kangude (2):
  dt-bindings: edac: Add cadence ddr mc support
  EDAC/Cadence:Add EDAC driver for cadence memory controller

 .../devicetree/bindings/edac/cdns,ddr-edac.yaml    |   45 ++
 drivers/edac/Kconfig                               |    8 +
 drivers/edac/Makefile                              |    1 +
 drivers/edac/cadence_edac.c                        |  641 ++++++++++++++++++++
 4 files changed, 695 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
 create mode 100644 drivers/edac/cadence_edac.c

