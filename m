Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F038017345D
	for <lists+linux-edac@lfdr.de>; Fri, 28 Feb 2020 10:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgB1Jnn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 28 Feb 2020 04:43:43 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:35810 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726005AbgB1Jnm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 28 Feb 2020 04:43:42 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01S9dgH5024994;
        Fri, 28 Feb 2020 01:43:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=fei+1EkzRukgHoU2oL8ccEl20bRBoqJ5tKPYO57SdLc=;
 b=GSoa1RXl8xmVl5efJRf514d5O1zXUw8NfW0Cy/bTgAGEZrGDPmpeTLCHFG2ssCPjWF6x
 301nzNSwIGHzgY/7EkBeUtyOth8KeC947BL9CnFzsJd4y46Ra9XJE8M8RMcoOKhHCZn6
 Mq13qQZDN0yk1BOmYr78igBJW/YnFBaUZWAyG9MLF8uhoE6H4Sm/6tslNiTQp5hrxDJx
 KIMylFtDACN5Wi5VsHio0HIXB6RZowf0VX/E214dtQaRJyCaZ9dy5OXSYVuXSReBUTvQ
 Opmljj5lZGXC27eW8yevFuoTvRC/jOAplr7AEN4Q5kJTg52dzDcgm4i8dOT3Q4HU77bl EQ== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2052.outbound.protection.outlook.com [104.47.46.52])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2yepvct0rd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Feb 2020 01:43:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlBtUIUqcnz0GwPOqLkEZx+uSJIT/4ET9uC2XnbULaw/aD90xu6hwfJoikzuVU5vk1Q0w1gEIAqwLaeX+8Kyldj/h82G5ZkXdpMcdKMBgniZcAD6eS1yBPOP4D1P+PxkhJqSH4BpKXLdT8dXAyWYOruK4bQM8RVpTmAn/bfKK+sbMj/nxL1aAtynn6pDgGUtsU3nTb719gA8UfkQ5/9GWSBIXLXH1p/jBtX9+L3VAjwbRZFs58s542OWWHSf2+jXZpUAh8f/GInblCi1kZsxEmIP7qNcf3cIcQ92Iuc+BKCjpawD6eeM9T5YEYSkIVOG9wczv+5B7LRJ+zBhOKRZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fei+1EkzRukgHoU2oL8ccEl20bRBoqJ5tKPYO57SdLc=;
 b=H3GjkaKnA5VTEoubCGIaJa8NQ+nQYV0ZUQ04rTCJp0RHVzoG72cQILv0Tu82xVf2KEevkwBafU9wVa4Y7KK0kntT9vB8OSpTQLa1ArfCHSHPxnmDnPojKJxD6SF3YvPMzyZb1zn1Au4YPN6pdognG65KPr7AVZ9voCUTQOVve3TlcddSnFoVe+/Hi7BY99NNLysmZwML82YbG42VYJL93lS7qtShKKG3x24TgARn6tGJ5jv2b+Xm7C+HBAiJBJ7yK/acmYz6xE5nxkOHxZWMf9Rp4aKE4uY77XJS74IW57kk3xuEEaMnLtrN+30MVRYm2j/keL/yb/yekdLiUhYFFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.28) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fei+1EkzRukgHoU2oL8ccEl20bRBoqJ5tKPYO57SdLc=;
 b=XGeUOs5ZB1hkjCkkY4eVgbvfC9tzA/BJIhKE+xZ8mR1CjtJT3HGu7Tik/nyCDvNZJ3JZaOGyR0xBrUArvXJSIc0vCsE87a+YfRw0S8N8AaF21XSVhDJfQzOzmCyI8vIPkSJJKda1iHLR/CJVAErBhSa2n893PhoBFUjf8E7O9os=
Received: from MWHPR14CA0071.namprd14.prod.outlook.com (2603:10b6:300:81::33)
 by CY4PR0701MB3636.namprd07.prod.outlook.com (2603:10b6:910:93::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Fri, 28 Feb
 2020 09:43:29 +0000
Received: from MW2NAM12FT044.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::f3) by MWHPR14CA0071.outlook.office365.com
 (2603:10b6:300:81::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Fri, 28 Feb 2020 09:43:29 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.28; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 MW2NAM12FT044.mail.protection.outlook.com (10.13.180.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.5 via Frontend Transport; Fri, 28 Feb 2020 09:43:28 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 01S9hPFH026489
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 28 Feb 2020 01:43:27 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 28 Feb 2020 10:43:24 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 28 Feb 2020 10:43:24 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 01S9hODU013664;
        Fri, 28 Feb 2020 10:43:24 +0100
Received: (from dkangude@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 01S9hORA013663;
        Fri, 28 Feb 2020 10:43:24 +0100
From:   Dhananjay Kangude <dkangude@cadence.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Dhananjay Kangude <dkangude@cadence.com>
Subject: [PATCH v1 0/2] Add EDAC support for Cadence ddr controller
Date:   Fri, 28 Feb 2020 10:43:20 +0100
Message-ID: <20200228094322.13617-1-dkangude@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(36092001)(336012)(2616005)(426003)(86362001)(4326008)(107886003)(5660300002)(186003)(26005)(70586007)(70206006)(2906002)(1076003)(356004)(6666004)(42186006)(316002)(54906003)(6916009)(478600001)(36756003)(8676002)(8936002)(7636002)(26826003)(246002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0701MB3636;H:sjmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:corp.Cadence.COM;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b58717a-53c2-43d8-f55d-08d7bc32aa39
X-MS-TrafficTypeDiagnostic: CY4PR0701MB3636:
X-Microsoft-Antispam-PRVS: <CY4PR0701MB3636B96C90C3BEB2C619D920CDE80@CY4PR0701MB3636.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-Forefront-PRVS: 0327618309
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4o5+1mylJfvpYVqo6W1VkP21sg7AYJUwJOuuGR1ASATn73fJu8V5t8YW0kVJqWV8aqzLoPtCnVMFdEckX6s3CTF48KDbvI9od2Ioxpz97si8iX+ZmNGhbOJb5caGdKruwv5Ag4XH0+r/s+sinanTcwuymqg7yHpI4uJnmDMeBUSf+YRYJu1pKIuEUSnsbdyBfHioG6qYwW1mtUgK7+x63V8HtuaO5SSgENmByBRQFbSO9pNA637bWZCo9viF3QSmgA42uMba6yrh4DVIgAbQmFGDk2Ze26c+z8QPyZT6WgAmMHZ8mkzSLzLvULtWrG4LhQl54bFfedX1wKca6UYmZQ4IAvqMGGNg9UFzr3VaVa9sfyBQRhS+d3PrTOSigZoRzI1V/M69yZvecN08qGsjZvFSXw0G/zdbPgpqvj/S785kwDmCxpqyIe2tLu09rzHUN9zZjphirlc+mKbAwwypH8V28r4IqufWiBGtrFri5VQG6kHtGgLQBzL7FqKHiJ+J
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 09:43:28.5876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b58717a-53c2-43d8-f55d-08d7bc32aa39
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0701MB3636
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-28_02:2020-02-26,2020-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 mlxlogscore=517
 clxscore=1015 adultscore=0 suspectscore=1 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280081
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

These patches add new edac driver for Cadence ddr memory controller.
Cadence controller detects single(CE) and double(UE) bit errors during
memory operations(RMW). DDR controller raised the interrupt on detection
of the ecc error event and fill the data into registers. Driver handle
the interrupt event and notify edac subsystem about ecc errors.

Changes since v1:
=================
- Made predefined arrays as static
 Fixes: 201447a5db9b ("EDAC/Cadence:Add EDAC driver for cadence memory controller")
- Replace macro 'EDAC_DIMM_PTR' with newly introduce function
- Removed unused variable root

Dhananjay Kangude (2):
  EDAC/Cadence:Add EDAC driver for cadence memory controller
  dt-bindings: edac: Add cadence ddr mc support

 .../devicetree/bindings/edac/cdns,ddr-edac.yaml    |  59 ++
 drivers/edac/Kconfig                               |   7 +
 drivers/edac/Makefile                              |   1 +
 drivers/edac/cadence_edac.c                        | 615 +++++++++++++++++++++
 4 files changed, 682 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
 create mode 100644 drivers/edac/cadence_edac.c


base-commit: ffa9a9758be2793d11b0c51bc2845f7dd200e261
-- 
2.15.0

