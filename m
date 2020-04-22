Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29C01B43A8
	for <lists+linux-edac@lfdr.de>; Wed, 22 Apr 2020 13:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgDVL7b (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Apr 2020 07:59:31 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:29342 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728203AbgDVL73 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 Apr 2020 07:59:29 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MBpS8v031960;
        Wed, 22 Apr 2020 04:58:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=y9OSyDZiDyHUyPp0nql0h+G17NB5aioZk3SV919nq50=;
 b=xAX6UH70Cabev7GVYwRo8bWikpq3BoCVnMaCCK39yxgdKfW27uJEZgWkWYYlk4uhxSaW
 F2uDVI0TdYa0W45KO+T7LsS28hvjdfZNFyVMrF1PvGRFdcELMht4s9W7R3DOgjM3E+s3
 9JxuWyWI+jnt9cYPAHNPlffqaZ11At+C73e6rQXLLOXnh77cTFbH0qpa0QOxXQG8xp6r
 cPnbnqouD28gFOywcM620klmUhaSWc5ceQ/pswyTd+lMVhf7KmREz41SRYPj/Xlk9Yri
 xS6OqOwzVDtypaGV0oqft7V19/711D7v9FKc+HDgeu0zCtg+ITzC4qNzKuVDBb+fi9I+ /A== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 30jd011w43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 04:58:51 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Apr
 2020 04:58:48 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Apr
 2020 04:58:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 22 Apr 2020 04:58:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kg2Ck1YrdoXSYW5MRFUEQ1cGeu2oP9dh5TwgWz8hg+RdrdD4KHMgpA0fL/sOEFQ/Ld3oadw1NNi3fc1M97/ahjzvpj0eII1r793GVzFMvV3QOOlDRQAR7TXSpTaPm//ZZzcgeqa8NXJ8cvyaHNkPbLIM7ZVytS4B5J137DU2xXSoW5cDIiDynF2pR9HmSHEgSAqVHgdwwL6GZDQVHuYJjlTlwIrwxmnboMi+ALNHJZCtY2ubQKZdzGwq0eLRbIb9pc8vCLfRGv3Iq077zzh3DUwADAK7jHfm88Ek1S2Vx+qQ6j7hzbJ7DCLWFprm8+4NRqSfzHWmxO0Uhnc57RR89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9OSyDZiDyHUyPp0nql0h+G17NB5aioZk3SV919nq50=;
 b=c4UMq+0VrJExaoaY5iJA2t1KrIRDgquNu6mZFctgK2lxXq131Pzq7bhvyoOFFpgX2aY52Obmtj5rb2K9r4HMYRrws81URPXnMu/qnz68XYcpIvpOKTFrgWO8hY67+ZqaR8S1/x7zwINc/8P/6TFbCXcPIVQQT+fnWjXvkr4E+EC16QBotFBROjSodjex7FN7MQG1oH/uK/0l30SXRE5qIR6YJBO641XP+BJEdUf1LjIICjm+Aahx3p6ORG+vqkPdLcEI7D6KCo0w7cDXJ6qLcGisAut9XDOuKmGvtTkQlrDrWqbC0cGsVztABCI+1vGgc61bXTFM2DEbTu1Xb0UXjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9OSyDZiDyHUyPp0nql0h+G17NB5aioZk3SV919nq50=;
 b=dEZtbG2ZNroHk+H4zbw5yRa9bolAtQIjCbTmdX7DP71ljYSv75E3/akv0jZBDDfmqlMatqNrmRYRP+m4z8o4cVFSFr4xy6Qr7WRcqOvWqENIkwRSuDDd7mRnDm1dNVz+zmF5TK8GItSsZoyUtBCWz5jP8oTYMh+L6QFs0MPggdc=
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2566.namprd18.prod.outlook.com (2603:10b6:a03:12f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Wed, 22 Apr
 2020 11:58:47 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 11:58:47 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 01/10] EDAC/mc: Fix usage of snprintf() and dimm location setup
Date:   Wed, 22 Apr 2020 13:58:05 +0200
Message-ID: <20200422115814.22205-2-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422115814.22205-1-rrichter@marvell.com>
References: <20200422115814.22205-1-rrichter@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0701CA0076.eurprd07.prod.outlook.com
 (2603:10a6:3:64::20) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0701CA0076.eurprd07.prod.outlook.com (2603:10a6:3:64::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6 via Frontend Transport; Wed, 22 Apr 2020 11:58:44 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d475e871-e7b8-4e0e-078b-08d7e6b48368
X-MS-TrafficTypeDiagnostic: BYAPR18MB2566:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR18MB2566C5352D04DA2CFA472001D9D20@BYAPR18MB2566.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(136003)(376002)(39850400004)(396003)(366004)(6506007)(66556008)(478600001)(2616005)(5660300002)(2906002)(8936002)(6512007)(6666004)(36756003)(16526019)(66476007)(186003)(66946007)(316002)(1076003)(6486002)(4326008)(52116002)(26005)(956004)(110136005)(8676002)(86362001)(81156014)(54906003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FIehxfIFc1BBnZ58txEHmilfvbESX9A3mA8zGDK5SReVu8J+h67VwpDlaRUsJQOgPunzhD7ViBcp/fCGQg+zNbRr3dp/kgFIn/HkGgejA4cPPNwTqGJCc7MFJ7g5SonkrbfzMqeS4nDWskxckedcnwFAabnnqemHSHVxmC+ultk3CAERCYaPKETxIyxdMg+CyGk/RK0JJ/wTe5nca7fepHd9xIyepy1HDUF/PjFYUkQdf8U+C+5hHeIDemzqnu0EclJsYYspsoJQsHERvWcMBzGawPZ1V3E1rmG8rTR5yOpgKoUNnlsrimQ/o0wJO4gQhd8/549rqObZUKZ89D1f/+exLUe7NwbTh/U3apbnBIr0UL5LkX7bZCxwsb4C96gFslqXw42aHi2foF0qbJaJQvMD+ekHfoaWZAleY7NSuOnAFVwpohbh1mk7/qNCqsCh
X-MS-Exchange-AntiSpam-MessageData: UFVznkGtVTcDABCVY9hTxg8yM6ZGdVC1dAl7R4O8zgmf3+3dgdZt5MBduSoeGTPVASNfJtcDWsBPIGxYjtOXA3ziCFT5oiJFXdsJwfNIxMgzbjOj3PcBw52pwVaOecteMS76+Yb4znz0GMqLnDdoOA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d475e871-e7b8-4e0e-078b-08d7e6b48368
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 11:58:47.2477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMP3ZERQVvqLvNHznOtxs96S9BwX7iJ0W2k1EjRf5rBbqbM1TjnQZ6Ks1w8SbFrTYQkYdIZ1+xnEK6JIEzFDuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2566
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_03:2020-04-22,2020-04-22 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The setup of the dimm->location may be incomplete in case writing to
dimm->label fails due to small buffer size. Fix this by iterating
through all existing layers.

Also, the return value of snprintf() can be higher than the number of
bytes written to the buffer in case it is to small. Fix usage of
snprintf() by either porting it to scnprintf() or fixing the handling
of the return code.

It is very unlikely the buffer is too small in practice, but fixing it
anyway.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 75ede27bdf6a..107d7c4de933 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -130,11 +130,11 @@ unsigned int edac_dimm_info_location(struct dimm_info *dimm, char *buf,
 		n = snprintf(p, len, "%s %d ",
 			      edac_layer_name[mci->layers[i].type],
 			      dimm->location[i]);
+		if (len <= n)
+			return count + len - 1;
 		p += n;
 		len -= n;
 		count += n;
-		if (!len)
-			break;
 	}
 
 	return count;
@@ -397,19 +397,19 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
 		 */
 		len = sizeof(dimm->label);
 		p = dimm->label;
-		n = snprintf(p, len, "mc#%u", mci->mc_idx);
+		n = scnprintf(p, len, "mc#%u", mci->mc_idx);
 		p += n;
 		len -= n;
+
 		for (layer = 0; layer < mci->n_layers; layer++) {
-			n = snprintf(p, len, "%s#%u",
-				     edac_layer_name[mci->layers[layer].type],
-				     pos[layer]);
+			dimm->location[layer] = pos[layer];
+			if (len <= 1)
+				continue;
+			n = scnprintf(p, len, "%s#%u",
+				edac_layer_name[mci->layers[layer].type],
+				pos[layer]);
 			p += n;
 			len -= n;
-			dimm->location[layer] = pos[layer];
-
-			if (len <= 0)
-				break;
 		}
 
 		/* Link it to the csrows old API data */
-- 
2.20.1

