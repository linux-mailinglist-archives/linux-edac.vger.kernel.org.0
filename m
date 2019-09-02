Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9AEA5622
	for <lists+linux-edac@lfdr.de>; Mon,  2 Sep 2019 14:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbfIBMd5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Sep 2019 08:33:57 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:4330 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730628AbfIBMd5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 Sep 2019 08:33:57 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x82CUiGp029652;
        Mon, 2 Sep 2019 05:33:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=q+UcsD8AVJ2yD4QdTpH5jA/xu0OUWHpb/y8uAIk8s68=;
 b=uH7TfZw9MChh4IMaSpbFwDUsQ6Pfj4/W87Yws3/du9h4oXPl48Dd/mSckexyi9curGGe
 z0gbHQ9tXSzrL8UHXW33uEwy2fxK+lL0Th2jVTMkACxox5G3cdH058t6UvDAP2SdkQ2f
 m+WxD2d8V7MRv/8WvZux6HQRuJXsjxBJPELo6yzAVZ8057VBIKIsXZoNT2a3du1TheE8
 L+z9LSRfR19dK0FAVjlva2KJYnhjiiXFCLVCYbdaD1c+tTxknRqN5Yysy3YTARerRhdM
 u2gdkuWhVoUdhV1YHufUYuKIdgQp9KI1kuOJqnjO4RmSnpYjNImXRkDUz+tlQW6mt1Zl GA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uqrdm603b-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Sep 2019 05:33:49 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 2 Sep
 2019 05:33:46 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.51) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 2 Sep 2019 05:33:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fh4Bxq5c2UexNaPKIZCCyFLH7Y1aifXekWglF0cOOCVdDZ3zf5l5+14zvzXSCtvBMLDzSf28+yFYezN+evc9nXYH78btJ1QD1TqdI3Ox2MpnCl+Ycgrzm7sEobgoW1pLiXPdBFSKvlxSv3zXNjahGfm79G0mR+Oq8EaV2caL9TXwETd/JXjW85xt3gtSuK+WRJVCN+3XcxCUtp/ede+r37jO4G7MeTvGxC2kXun3kXUnGwrhu723BjhH1BpFDIGbSzChjdpFPnSSQEWyt9I6wRk/9blRGKNJfNGOyrlpxCrodGT9Uwl3HGerlKeS6MjC0G6BbSpCs8QPVATqPkDT1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+UcsD8AVJ2yD4QdTpH5jA/xu0OUWHpb/y8uAIk8s68=;
 b=HeZCymd4TksqxOQtVoRdObWYtq3TGHvedO6WZKVuoY4+nPvHjs8aY0KmgYEUrz76xL46NhvE5cbCAgcTm6nGIetUH4iIXxgRHAGTgLphNqIgzZlh+gZAYqRZMsgg6xzR8K76I2Gc/S+mA/vbIzbKoQuprl56vC57uWOESu3rhC28/woh4SndsWb2+wAOSqc+/CKqIKbQKMucUhQ76je8AA8y3pxAaW9k7GCYXfV6BcN4vnBmhUpS13ycoAeEVEZbpGYAzwzYzFVFkY4a1KAAk3FtHEyXgMFkuiuqdT7sUzpJtkcffmVtgdIM7Z47+K3ZkR7ds0k7pBJw0m2Ciq55Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+UcsD8AVJ2yD4QdTpH5jA/xu0OUWHpb/y8uAIk8s68=;
 b=KD6arz5pfDr7GufXAhRVRz3Nns3QhODeZjHxv9UF8HJPE5IFQPTI6Of34Pvoh6kDL7m4LksjlFCkIeUEMOEDrk+OuLXcz6de+SKo1j2kE2Ny7Tjar45Z4PWpgdIN90WO3mbPQS3DE7i4akwY5rOFBNHmXZGwO2e66SPIWV+QaeQ=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2480.namprd18.prod.outlook.com (20.179.82.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Mon, 2 Sep 2019 12:33:45 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b%3]) with mapi id 15.20.2220.013; Mon, 2 Sep 2019
 12:33:45 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     Robert Richter <rrichter@marvell.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] EDAC, mc_sysfs: Remove pointless gotos
Thread-Topic: [PATCH 3/5] EDAC, mc_sysfs: Remove pointless gotos
Thread-Index: AQHVYYqpgvER4zlKe0KU5vpskR3bNg==
Date:   Mon, 2 Sep 2019 12:33:45 +0000
Message-ID: <20190902123216.9809-4-rrichter@marvell.com>
References: <20190902123216.9809-1-rrichter@marvell.com>
In-Reply-To: <20190902123216.9809-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0027.eurprd07.prod.outlook.com
 (2603:10a6:7:66::13) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b02db0a-334c-4ac2-f2df-08d72fa1cbc8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2480;
x-ms-traffictypediagnostic: MN2PR18MB2480:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB24808BFB42F07AC334005F38D9BE0@MN2PR18MB2480.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:82;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39850400004)(396003)(136003)(366004)(199004)(189003)(6486002)(8676002)(186003)(110136005)(81166006)(81156014)(71190400001)(66066001)(6506007)(386003)(1076003)(71200400001)(26005)(6512007)(53936002)(256004)(478600001)(50226002)(54906003)(86362001)(36756003)(8936002)(14444005)(52116002)(66556008)(66476007)(486006)(5660300002)(64756008)(66446008)(11346002)(2616005)(4326008)(316002)(476003)(2906002)(7736002)(76176011)(6436002)(305945005)(6116002)(3846002)(99286004)(102836004)(14454004)(446003)(66946007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2480;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uAkVfy0j3B7glonPo475z/1JTiVwMj+bgixN5I7PkMC27Cy666Jt9Ls4w666hobHigYaZeaYC3tYq+sKQkck+Io/o/TdUdHhYMC1aJLTJeDfz8p3UAp7XHBVntTh95qLdSK7L74Xu7eJBgquLI+J10ValZXlRphXpT3dgVYP5Z7ktd3rtisEnIo6DnorWzznLL6KOH2PW9VvsgiQIz8zWiXTE/lWDlUhEd48lkPJ/wLgHURdBv4l2wOXbaRtBQa/TxTlvG62Oaym1S+ogW5TAmRz3iLxopZQAWVwrgYsHEEPBPreUD9TZpYy11d5+p8PSZMILlB/0SIVFDRB1yFcohGIozDawkkYUgyUPgMtCfjonVsuDWvXEyEf7fCeJik8yFE/Bfzua/HCoz85krkCtIRe2GUbq2xKN/D+mo5noq4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b02db0a-334c-4ac2-f2df-08d72fa1cbc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 12:33:45.3057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nj3Fu1uBejGQhu55V+cItKvFWM8s25QR16qgbYnNXvTlxzi23yJmrWcmTdWEZGIuF5b5HRa7x9Z5x3rqbTua9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2480
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_04:2019-08-29,2019-09-02 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Use direct returns instead of gotos. Error handling code becomes
smaller and better readable.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc_sysfs.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 4eb8c5ceb973..309fc24339b0 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -938,7 +938,7 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *m=
ci,
 	if (err < 0) {
 		edac_dbg(1, "failure: create device %s\n", dev_name(&mci->dev));
 		put_device(&mci->dev);
-		goto out;
+		return err;
 	}
=20
 	/*
@@ -987,7 +987,6 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *m=
ci,
 	}
 	device_unregister(&mci->dev);
=20
-out:
 	return err;
 }
=20
@@ -1044,10 +1043,8 @@ int __init edac_mc_sysfs_init(void)
 	int err;
=20
 	mci_pdev =3D kzalloc(sizeof(*mci_pdev), GFP_KERNEL);
-	if (!mci_pdev) {
-		err =3D -ENOMEM;
-		goto out;
-	}
+	if (!mci_pdev)
+		return -ENOMEM;
=20
 	mci_pdev->bus =3D edac_get_sysfs_subsys();
 	mci_pdev->type =3D &mc_attr_type;
@@ -1055,17 +1052,14 @@ int __init edac_mc_sysfs_init(void)
 	dev_set_name(mci_pdev, "mc");
=20
 	err =3D device_add(mci_pdev);
-	if (err < 0)
-		goto out_put_device;
+	if (err < 0) {
+		put_device(mci_pdev);
+		return err;
+	}
=20
 	edac_dbg(0, "device %s created\n", dev_name(mci_pdev));
=20
 	return 0;
-
- out_put_device:
-	put_device(mci_pdev);
- out:
-	return err;
 }
=20
 void edac_mc_sysfs_exit(void)
--=20
2.20.1

