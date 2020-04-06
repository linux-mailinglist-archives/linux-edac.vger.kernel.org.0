Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C84BC19F688
	for <lists+linux-edac@lfdr.de>; Mon,  6 Apr 2020 15:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgDFNOC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 6 Apr 2020 09:14:02 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:33888 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728257AbgDFNOB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 6 Apr 2020 09:14:01 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036D58nl016507;
        Mon, 6 Apr 2020 06:13:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=/pTbnXhBzyosxdrzMweG4AqAqVELgwwKmGvZwRXxmP8=;
 b=X2pXKP0hN27UKkTiBOeLooGnbZh+5aCF0dDDFJCU41ugoz6k5fgF7H4Te4tbFatCPSUq
 ZrZ+u0lzqRbAbFl7o2YD53rR4UdcnoAdAPLkqbwBnmLtfpvdHDsRk9GtlthT6UrzGHTO
 XWGstynOeNoE2eqBu5GMlgCow0utXuaafAbmV+rIXEuH+CKhqhRiFFq3sRWgR1wEdkTN
 YN39QA47OtXWWNWp3tXir/8YARAvoSvAFMbetlQ0YVnQrsgwjAT5HTAz+p07x9ucESap
 6a40+fOWBXHakAT6M+VfMVU2Q9PVTtah9Jjs7mYDlMS37jTTylE31muZvNQHVvncofYz xg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 306ntxxmbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Apr 2020 06:13:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEv4FjQHsCzgvE5gVjlAGh8R5olBA/MqdDRA65flrEepUqAR0efhXTvDspRlMUlxzSAZuoGZdd12i2HoWE6cNmsUQaczCfb120WqfUevdOtYA6i/VlCudOE0FwPwu5mR5bAHS9OvDrLFR06X6rTZb/nDC4GFRyGhYX4rZe/Kyoc1EIr/5YJ3ulmF3J1ExI23GgI+0aoIxltdFvp/v3HC7AQBlYfuMPKptyfl/YxM7JWC7X7AuSTi/j15mlzJHxoBTTTxllGhYXZsm6+GNadBs14LPE/tTW5wdDcBeQf19YuOJTnL5N1mRpREV3Ta8KPYJkAfX7cDrzPK/70jqYRprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pTbnXhBzyosxdrzMweG4AqAqVELgwwKmGvZwRXxmP8=;
 b=hWeHnKLRoIVXBgi2xOl8w/3ZtxcPOQQAU5+upc9acvd27N75Jvr6T+6fxH6DjbT5ewlIkLPJ5ZVllh+q9/D/6jI9wlSTt0Vuzi00SS4ucANzMqSL4XsDkhHmnP0zPwxHDQbP8/6X6Q51MuH5IhFwKvarh6TzKnIjM3V9RWDWQ3OE40l5YZnlWF73CCpCQ8zISFslM9bBbF3VdCU0HgQqvfMqZ1VAXl6NFRupt93bxuLhwsP6zqsSxnuH1ox17F4l8iBBYD7CDNEbndOZTmlohCZAKY6gHKkwYPufYOVUCpZNYpQfRkt+eoSiSea4z6Imt7br8i2Ji/+YjdOb1xfq4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pTbnXhBzyosxdrzMweG4AqAqVELgwwKmGvZwRXxmP8=;
 b=SSiuehVU7acSJbdc/OBKuaff33C6og45TAXa+qhZSgRLWHr83z06x9xhWwJhjmZvFELKnPp4IubRNnw6Ft7XSSuG7W1RpL4VcfCJzPT8YMoE/lSskad5m7B688nBHvtP46yVDkOPfDbPHRS5fBK4lfTZi1tVplD2X+w+CjVgHlg=
Received: from BN6PR1701CA0010.namprd17.prod.outlook.com
 (2603:10b6:405:15::20) by DM6PR07MB5100.namprd07.prod.outlook.com
 (2603:10b6:5:52::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Mon, 6 Apr
 2020 13:13:48 +0000
Received: from BN8NAM12FT042.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::d0) by BN6PR1701CA0010.outlook.office365.com
 (2603:10b6:405:15::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Mon, 6 Apr 2020 13:13:48 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT042.mail.protection.outlook.com (10.13.182.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.9 via Frontend Transport; Mon, 6 Apr 2020 13:13:48 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 036DDiTc018857
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 6 Apr 2020 06:13:45 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 6 Apr 2020 15:13:43 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 6 Apr 2020 15:13:43 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 036DDhdu001333;
        Mon, 6 Apr 2020 15:13:43 +0200
Received: (from dkangude@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 036DDhqD001330;
        Mon, 6 Apr 2020 15:13:43 +0200
From:   Dhananjay Kangude <dkangude@cadence.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Dhananjay Kangude <dkangude@cadence.com>
Subject: [PATCH v3 0/2] Add EDAC support for Cadence ddr controller
Date:   Mon, 6 Apr 2020 15:13:39 +0200
Message-ID: <20200406131341.1253-1-dkangude@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.cadence.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(36092001)(46966005)(478600001)(8936002)(26826003)(107886003)(47076004)(8676002)(7636002)(356004)(6666004)(246002)(70586007)(70206006)(5660300002)(36756003)(2906002)(336012)(26005)(2616005)(54906003)(42186006)(316002)(6916009)(36906005)(86362001)(186003)(82740400003)(426003)(4326008)(1076003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15a420f7-624e-4b30-a322-08d7da2c5800
X-MS-TrafficTypeDiagnostic: DM6PR07MB5100:
X-Microsoft-Antispam-PRVS: <DM6PR07MB51005E415AED994AFED8C5CFCDC20@DM6PR07MB5100.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0365C0E14B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GYkHIADaexDXFVYsEbiklfevIzfrUvrrmFQWepXU+fFAD5AedGNoI8CixY+KDqaEgpJoWW5TvIA0ZN3B0J8u4TeM/XH+EzzyjmX6fiLmXc4ssnOTONVRiFS0l/0sZR6mpmo231l5F8x2UM8d6y4Vq83E30nD/+StxWTk1RcyBoPoRdzjbaHiMrhP5xAWbwx3Z3XC2iFL/xC0lfUNwk+pue4lcYGgpHQ4L14cLc80d+SEJ+IxXnL0Pe23QnsJM1KwHPJc7xlNTurGnizeAQ49ua75g18hKpR5978NxRQ5kEIvso7NdgM35HfVcMfU68vqDBmoBlGi3SnbekWIsnRl+sa7TtqF0zN3g64qBzjdwgCfgkVcO1RkPISat95Eoz3XAkLSBvIJAKeZ4OlN6KKaxRPdMl3NonAjORRLhBXTXjrPQr3ruhfx4GVPd0E+RyB2BOcWtoaTEQgd/LUB2i6aW1GW0ATE9mqlD6N8q3QKr+62roFX7fMplJKekT4HVA4P5+qDLhV6vLvLi2VlDZP/DtLWewL/WdzkZffsZ6I+2xA=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 13:13:48.4678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a420f7-624e-4b30-a322-08d7da2c5800
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5100
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_07:2020-04-06,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=542
 spamscore=0 suspectscore=1 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060112
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

These patches add new edac driver for Cadence ddr memory controller.
Cadence controller detects single(CE) and double(UE) bit errors during
memory operations(RMW). DDR controller raised the interrupt on detection
of the ecc error event and fill the data into registers. Driver handle
the interrupt event and notify edac subsystem about ecc errors.

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
- Removed unused variable root

Dhananjay Kangude (2):
  dt-bindings: edac: Add cadence ddr mc support
  EDAC/Cadence:Add EDAC driver for cadence memory controller

 .../devicetree/bindings/edac/cdns,ddr-edac.yaml    |   47 ++
 drivers/edac/Kconfig                               |    8 +
 drivers/edac/cadence_edac.c                        |  641 ++++++++++++++++++++
 3 files changed, 696 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
 create mode 100644 drivers/edac/cadence_edac.c

