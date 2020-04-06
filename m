Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80DA219F264
	for <lists+linux-edac@lfdr.de>; Mon,  6 Apr 2020 11:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgDFJWe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 6 Apr 2020 05:22:34 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:21630 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726701AbgDFJWe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 6 Apr 2020 05:22:34 -0400
X-Greylist: delayed 1659 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Apr 2020 05:22:33 EDT
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0368l2Y5003853;
        Mon, 6 Apr 2020 01:54:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=hw1jLeC6H7wNEPLHCSw7kFD1EFLkp0M2cp8w/uwSQGU=;
 b=UCAlchR4P2lxUVfQ0C7509WbKXYvk0rKSYk+dbucp+6DnvGAGI5QPWiDoluHxfJK9B8W
 X1GFB0Ldp3gASUyQ6y0B/iVTMkpZ4pbGZQ6olbl3gxWscOEpMMuuDXHVvtFzJ5yFDgrI
 atM6bE+e58vSeGVCWp3IYfxqw4HV7LNeUonvUGsZF524UzXu0zPs3ttmW3g01lobgh2Q
 tqopGRN3fOQd5nBwyIKUeAJPmdVZbKlyHgfcOTVtATJijtaCWssb31OAH/BO+xCW+1eA
 chU/4Uk5f3Ov6OFyNupl8VvqoLOole4C2N+zv1NeYEHMSy2bcEY/wYuEsMKJlJfI7AdK Kw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-0014ca01.pphosted.com with ESMTP id 306psvwmy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Apr 2020 01:54:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndjiCwzHOetYY4gUsBFaNnkfNsB5JTiiC5LNsTBztPoRrcaOvNixetMSuXreXrFoBf5aMFb/m8SrYpx+iOeGqM6aDzzEcmT63RxyEp4wS4s8gHUUN0FAQvEs2L1zjaSeJpaXltvnqbGvRJBIFp/wD4o5GSvR39xDMMsNqveE/RdHIGuppxrlLwXS64yr7PyWhqlTpzijx9ekgaFWMUbruwPQDVWkRYmPrRbBX1lajfvhSOyAQ+IuuOIw+v7ierSD5bXNKU9IAhknJh93cUfT6ktcRBrSal2OlmtSvrwIg95iQFtKX+S4B+9hpbicl+LpGHn3kcVz5M6FqiE/8p7Zjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hw1jLeC6H7wNEPLHCSw7kFD1EFLkp0M2cp8w/uwSQGU=;
 b=mUShA7rWqvRXYDF7a7hgITRi2WammHw7PS5h0NXbFeU7VubHuo0nuv+moajg2FoOnlJQGMUeDG078WxFEyCqSzGUwUzAfIaZjCTdN6gxOvk9vhYTKhVYLHGTKdtJ/NqmqPzMybc70FgsR+5UpFOlj69RY5ahpXxXkWyV7WLytxNTXR2hMJSCi4Yc4MRPM8wyoRA6aqJAK/g9q2miUAA7ylhvhdzWfxKD5vuPSRsiMWLyS1Ldmo0yg+9hFkLR8oDcs9WVvywMBHD+1fN8lAUJbdMOQN0KiDqQ7jJ+olBF+fPSV3JwT2fBMdtAV2i2TIwLgtkPL/mWI65aTq1YgEvB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hw1jLeC6H7wNEPLHCSw7kFD1EFLkp0M2cp8w/uwSQGU=;
 b=CKlwvlkRtcvxYWRMs7aOnJnGF8n//pUVv2SWJE8UigS6ff6YK4uNt+hpOJXEUSB8790TalPXcGmul+wh/t2CWdnu+aHP+LlLnG8E72ytZDW1o0LrkSB0X/Ld4rDC78lRT+MA4K67lapgHzW/n+6c1UyohLwk+zbTN+5fLvvVMhk=
Received: from MWHPR18CA0041.namprd18.prod.outlook.com (2603:10b6:320:31::27)
 by MW2PR07MB4010.namprd07.prod.outlook.com (2603:10b6:907:4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Mon, 6 Apr
 2020 08:54:38 +0000
Received: from MW2NAM12FT013.eop-nam12.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::bf) by MWHPR18CA0041.outlook.office365.com
 (2603:10b6:320:31::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Mon, 6 Apr 2020 08:54:38 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT013.mail.protection.outlook.com (10.13.180.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.9 via Frontend Transport; Mon, 6 Apr 2020 08:54:36 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0368sWmp015091
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 6 Apr 2020 01:54:34 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 6 Apr 2020 10:54:32 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 6 Apr 2020 10:54:32 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0368sWwK004290;
        Mon, 6 Apr 2020 10:54:32 +0200
Received: (from dkangude@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0368sVYo004283;
        Mon, 6 Apr 2020 10:54:31 +0200
From:   Dhananjay Kangude <dkangude@cadence.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Dhananjay Kangude <dkangude@cadence.com>
Subject: [PATCH v2 0/2] Add EDAC support for Cadence ddr controller
Date:   Mon, 6 Apr 2020 10:54:02 +0200
Message-ID: <20200406085404.3983-1-dkangude@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(36092001)(46966005)(4326008)(70586007)(36756003)(107886003)(356004)(6666004)(336012)(26005)(1076003)(426003)(81156014)(2616005)(186003)(8936002)(8676002)(5660300002)(47076004)(36906005)(42186006)(478600001)(81166006)(70206006)(82740400003)(26826003)(54906003)(86362001)(6916009)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d97a432-d444-4068-6fc9-08d7da082268
X-MS-TrafficTypeDiagnostic: MW2PR07MB4010:
X-Microsoft-Antispam-PRVS: <MW2PR07MB401094230BCCA87DB156A10BCDC20@MW2PR07MB4010.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0365C0E14B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LOcolp50ktCVIFpquHcDGNXDyaPdKHPjPqkj/zBOsqdsBsH7j8NshmgaxT7lx96lF8/SNAfaODbU4f5XQPWDRX4KRFPuW0/zYzagRWjDlFyEk48Vl8kw87nsN1hCRl98ByWjYcaKTgd57UwnDKZRBFz0iDUPW8VIxSYo4lOoPq1Z7mVivDH19YULLMANa7DVJhp9q9zMJag1gk5Tpg2KlDr1Mhw0EDmi7aFmkGPyt9yF8VdeQPJfQLgA/76WGMMEgGYuIHJk5ttaZXTwgOFa/gZcpMmN68OizotqIW0djTem5rur0HW69W4Hzql0PmrFmIE6yGPLjDtQ9V0u9FbmwWEFrbTzpOFz5zarCvgoEamZQO87KLQehQXam8rY1WRHROvotJ55+6YXtFRvot8yhLz1bGyY0yrOINTqQnma1bKU/wx3zFnlxzOH7bsFqW3MkqvCA4gaH5/o1/elzvfgAO80tJ366h6hjSUPM/LOJ3cjRDwXwv7EseUtVuBYUahhcDhbX+/Bpyhz3PUP+42gYiZbuNn0TC9h+CMCb4rtotk=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 08:54:36.7398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d97a432-d444-4068-6fc9-08d7da082268
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB4010
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_05:2020-04-03,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 spamscore=0 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=509 mlxscore=0 suspectscore=1
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060076
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

These patches add new edac driver for Cadence ddr memory controller.
Cadence controller detects single(CE) and double(UE) bit errors during
memory operations(RMW). DDR controller raised the interrupt on detection
of the ecc error event and fill the data into registers. Driver handle
the interrupt event and notify edac subsystem about ecc errors.

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
- Removed unused variable root

Dhananjay Kangude (2):
  dt-bindings: edac: Add cadence ddr mc support
  EDAC/Cadence:Add EDAC driver for cadence memory controller

 .../devicetree/bindings/cdns,ddr-edac.yaml         |   47 ++
 drivers/edac/Kconfig                               |    8 +
 drivers/edac/cadence_edac.c                        |  641 ++++++++++++++++++++
 3 files changed, 696 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cdns,ddr-edac.yaml
 create mode 100644 drivers/edac/cadence_edac.c

