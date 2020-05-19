Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479601D9499
	for <lists+linux-edac@lfdr.de>; Tue, 19 May 2020 12:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgESKpr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 May 2020 06:45:47 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:59142 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728686AbgESKpn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 May 2020 06:45:43 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04JAepe6030448;
        Tue, 19 May 2020 03:45:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=egmW+7fOU3wI49v5Mo473K16edes6eXSnfW6okNrywk=;
 b=EhnsoZyDdkCfY/PGnY4N7V+ZUOnQVUpVDv122BXagX3SIqF+skzx29BCZehJBO3D/SUe
 dnl2sr9YIWx5hhuxQgrgflRpPbkSJvx8Wr2cNCIWdu2wMMZx7q0ir1S4d9IW2WzitI/d
 zQ2SjEqS0bcVTGUYsdOwRQbFGaI7IElUBw4IGV0KjmMLGnEAFJe0vDhEMWWsIoLrmLue
 npcxmas53UJQTnQiKjInrPn5NGTOJuSTWNKdih2S38nov0G263OqUFWVwLSAHZDdlS1L
 yBy3PuHsSNCyE0UjRVowRrHk8J8hv+6ylT1p+i9kOdy4pEpCvStdK90DF9VoUH0F0yLx uQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 312fpp2ybw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 May 2020 03:45:31 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 May
 2020 03:45:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 19 May 2020 03:45:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCL2s68V8HCmpvP7VUA5KD7onxkEAbOjO4RmQh2kevD8yI+ItT24Pd+Fq8yFXsovF21dsZ+HME7ox6Kp//RxWxTP2Up4VbdWBTDGsJ8oJwuZ4Da5bE2yR10XUsLJrYCdJk16SbEKCXG6/spPhJB1bHOvLbHXt9aAZnRBzqDUmj4of+XCxi1HVastQH1PbC0EUN19FqQzPSPoecaVRCsMk3JsJ2We6EAM5rY/UwoubIuUAM3Du5PP/0XBftHZREFoRob/aX17P7Rxl43c/s8TLz+of4bmW+crm2Etd/VCD3ro+anv42+H0N5Q0l8Zl/T7gAc0Moj2ERZwMWs7yplQ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egmW+7fOU3wI49v5Mo473K16edes6eXSnfW6okNrywk=;
 b=QkeQ/92kq0ksYH6h0iQfE//OpLorFWgEF3aeQ+3pZLRtUYh2a+BQbDg6MC/GpnljNlBgSobMw9iOEz29ztRnWBWWyk0UIr+iitUAYRSpiDs3R1coXWWKQ4tVN64PAoftdN1sQI6D+mkRK7emJ0Q/zmr8H3TYNFqSqHCM7wEyF5ORHkkXnFSfCcmw0NWTNAhfW4u2ObNrR0QI7zZWMmu3bZWIXQvj4JfrtjnsPnk4J+8TWZzjDnLPCPis6YXlORShJ/k/iOGGyJJ9AD940ySNXA4NSfh+rG61SHsJA0nq/Poiinu0CI6LPMk59o5w53dWs1MysFFfAfWVhKpQjZiAYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egmW+7fOU3wI49v5Mo473K16edes6eXSnfW6okNrywk=;
 b=MxMn91BrGRdyi/yBeQEbFM2UqGgjcALWWAxWyMXYtjaZmeXiSJH0nzzLXyopQiMzR3SObdVPVUZAsOTf/pVfe8h/hKWPzrhnOC2rhqFZdp6uFec2yQ6lNqvMaM2eyx7ovCiHYFokfNuo1Krm3FnTgRF41CFqYDMrlFi0wCfisCA=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=marvell.com;
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2455.namprd18.prod.outlook.com (2603:10b6:a03:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 10:45:28 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.3021.020; Tue, 19 May 2020
 10:45:28 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/5] EDAC/ghes: Have a separate code path for creating the fake MC
Date:   Tue, 19 May 2020 12:44:42 +0200
Message-ID: <20200519104443.15673-5-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519104443.15673-1-rrichter@marvell.com>
References: <20200519104443.15673-1-rrichter@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P189CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::36)
 To BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1P189CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Tue, 19 May 2020 10:45:26 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2318a0b3-6a75-4cb5-3379-08d7fbe1beb9
X-MS-TrafficTypeDiagnostic: BYAPR18MB2455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR18MB2455193C62D8BE1444AB7B70D9B90@BYAPR18MB2455.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:303;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fvAqKAXzZaU+eDnBXSrsB5yB6kyja+V+aA7CLbTwibNOrwncUCqFWsZAd33hhOZIQAgVxq9Ywl2tIRfq5hONAm0+9qow3dXeCBUlUCwaVSJOxg6ApEYTix6NAERH/qCGrzA9kKw6R2b9QzM7DHcJzC4gvXns1jubzFCoXrLbegvDIHLuCLmGLqxBkkn8MA1seaF3mwdd32KPj4hktwbE/Z0IPXYs5MNELmRxMHK/gjnbUlAvf3n4diCWbGBp0YWFWqwQLscFaMiRThNWXaZmNYuooRf3TxskwxfDvdBy7jC9WmnzK/ngH9yvkmQa8dPlPreiCaa0OjOvLnkulqxRQbfXxwIWguWF4fhatJEkXr/wx6dktRja2Zzd6QF4bcGycADifPGGrhzGWnAWF/y9a8TyEQcSQl9ZKH6yg4/ofwgEs7lLPo6UK8HF5sa5sSk0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(186003)(316002)(16526019)(6666004)(956004)(2616005)(36756003)(8936002)(110136005)(86362001)(66946007)(6486002)(54906003)(26005)(5660300002)(6506007)(66556008)(6512007)(66476007)(52116002)(478600001)(8676002)(1076003)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GAqqQDUfuGnAygXCVhjny3AMmmJTW5Y3Y1IivmWo1VuE5yps6TSbTVMmUm/HZbpkF9vL8mq4jRJF9K9JwQII1iJPmCPyuL4DgdWU9CeshW6bB9dX8MBUW8rl0JtwBNf3UxPdZbzLccUKufkm4hvTTRKhx5NjqhUQEgMwtl6nTyl4AVeGyv2BX3mUbSX4vn8X7QMvXfKkiovTyqen4eREHDDJyGjZSXDgt2jee1a579RvXumayaE75zROmDanTL2941VCnwZOTAgknYHkWgsU02Jpxs87WODUUI265ZBp85OcNK/lthHqxvZ5SprUSTVa49wl+Wn5Rd1woFvxWH5pFilxq6ap6JWZ9WphZ044QaK0CYjrFK7cYFXA84Ju6PGvnNo1zeNsPCgK6WB7aPnDdq4Zt9l61OcugXh39sPHo0FMgAX7dkC8HV9J132aZQP7IJKaK6GBa7MudUg+XdcQ2e7J2SUGMcLphX5dKfF/xlE=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2318a0b3-6a75-4cb5-3379-08d7fbe1beb9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 10:45:28.5094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbH/WlSN+z7F8c5UciqlSbXQzUlVoLsbRFrbk8vgzvHJRgHLk54/LC8wP0dac4FJ/pXIS7ryYqARAT2+OwvhgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2455
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-19_03:2020-05-19,2020-05-19 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The code in ghes_edac_register() switches back and forth between
standard and fake controller creation. Do one thing only and separate
the code path that creates the fake MC.

Note: For better review the code is not yet carved out in separate
functions.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 73 +++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 27 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 8329af037fbe..47b99e0fea6d 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -536,7 +536,6 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	struct dimm_fill dimm_fill;
 	int rc = 0, num_dimm = 0;
 	struct mem_ctl_info *mci;
-	bool fake = false;
 	int idx;
 
 	if (IS_ENABLED(CONFIG_X86)) {
@@ -560,24 +559,44 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	/* Get the number of DIMMs */
 	dmi_walk(ghes_edac_count_dimms, &num_dimm);
 
-	/* Check if we've got a bogus BIOS */
-	if (num_dimm == 0) {
-		fake = true;
-		num_dimm = 1;
-	}
+	if (!num_dimm) {
+		/*
+		 * Bogus BIOS: Ignore DMI topology and use a single MC
+		 * with only one DIMM for the whole address range to
+		 * catch all errros.
+		 */
+		struct dimm_info *dimm;
 
-	mci = ghes_mc_create(dev, 0, num_dimm);
-	if (!mci) {
-		pr_info("Can't allocate memory for EDAC data\n");
-		rc = -ENOMEM;
-		goto unlock;
-	}
+		mci = ghes_mc_create(dev, 0, 1);
+		if (!mci) {
+			rc = -ENOMEM;
+			goto unlock;
+		}
+
+		dimm = edac_get_dimm_by_index(mci, 0);
+
+		dimm->nr_pages = 1;
+		dimm->grain = 128;
+		dimm->mtype = MEM_UNKNOWN;
+		dimm->dtype = DEV_UNKNOWN;
+		dimm->edac_mode = EDAC_SECDED;
+
+		snprintf(dimm->label, sizeof(dimm->label), "unknown memory");
+
+		rc = ghes_mc_add(mci);
+		if (rc) {
+			ghes_mc_destroy(mci);
+			goto unlock;
+		}
 
-	if (fake) {
 		pr_info("This system has a very crappy BIOS: It doesn't even list the DIMMS.\n");
 		pr_info("Its SMBIOS info is wrong. It is doubtful that the error report would\n");
 		pr_info("work on such system. Use this driver with caution\n");
-	} else if (idx < 0) {
+
+		goto out;
+	}
+
+	if (idx < 0) {
 		pr_info("This EDAC driver relies on BIOS to enumerate memory and get error reports.\n");
 		pr_info("Unfortunately, not all BIOSes reflect the memory layout correctly.\n");
 		pr_info("So, the end result of using this driver varies from vendor to vendor.\n");
@@ -586,31 +605,31 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		pr_info("This system has %d DIMM sockets.\n", num_dimm);
 	}
 
-	if (!fake) {
-		dimm_fill.index = 0;
-		dimm_fill.mci = mci;
-		dmi_walk(ghes_edac_dmidecode, &dimm_fill);
-	} else {
-		struct dimm_info *dimm = edac_get_dimm_by_index(mci, 0);
-
-		dimm->nr_pages = 1;
-		dimm->grain = 128;
-		dimm->mtype = MEM_UNKNOWN;
-		dimm->dtype = DEV_UNKNOWN;
-		dimm->edac_mode = EDAC_SECDED;
+	mci = ghes_mc_create(dev, 0, num_dimm);
+	if (!mci) {
+		rc = -ENOMEM;
+		goto unlock;
 	}
 
+	dimm_fill.index = 0;
+	dimm_fill.mci = mci;
+
+	dmi_walk(ghes_edac_dmidecode, &dimm_fill);
+
 	rc = ghes_mc_add(mci);
 	if (rc < 0) {
-		pr_info("Can't register at EDAC core\n");
 		ghes_mc_destroy(mci);
 		goto unlock;
 	}
 
+out:
 	/* only set on success */
 	refcount_set(&ghes_refcount, 1);
 
 unlock:
+	if (rc < 0)
+		pr_info("Can't register at EDAC core\n");
+
 	mutex_unlock(&ghes_reg_mutex);
 
 	return rc;
-- 
2.20.1

