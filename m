Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0376BA5620
	for <lists+linux-edac@lfdr.de>; Mon,  2 Sep 2019 14:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbfIBMd5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Sep 2019 08:33:57 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:40270 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731634AbfIBMd5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 Sep 2019 08:33:57 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x82CUiGn029652;
        Mon, 2 Sep 2019 05:33:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=b4H7jvs/togG3+26Ds/1XqTEtiHB5CxN8IOMuJN/PBo=;
 b=y4oVkVxZ7+oIYj9pcUjoDOHfaTkDqf4EEVIscH1ET3KyFxXSR3MXtiO1TDhV+8rRi3gg
 N4U/cjYRWq9wgv5eXD3T3F9DuohOfSxwkMYjqn6oTJLjs4cOu3umUihTgu7d1oGBNnvQ
 +Rb80mZjWkFTk5PZQpdbNxo4z0eYPX9gJt0hZSWk2WHqzMucUkE7ZkvuyIbz/kvUtkhG
 B0JbcCbtRGkyIFKwryeIVfyMJ/c/UBENG0/WhKRYdoWMIV+BEwvlONsP2kJV+56udZBg
 zRhTtuRT42LXPp8ICoWDz3Q8kElUxtMcp2Ll3T6NZNTZbBMkUbLNXOFYCIptqJHKN3o8 7Q== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uqrdm6038-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Sep 2019 05:33:46 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 2 Sep
 2019 05:33:44 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.57) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 2 Sep 2019 05:33:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJ8IK76AaNDEDq0bdPHC0MdZtXZc17mBTsSxs2GifHP2xYFXdLPE+SLFl5HtaRsc0U5hlePYv92vf0Y+Jp0/RP9pLma9UGLcYXHJ4xaTTNAZWUcnnQGCMFnI0PGq8CGI3JZbZ+D5GFsdEjOxqIPRHTv9WS34ib85/k24Vc8emafBae3V0OV/x9fxPIvU88elbuGLzb1YlTVwyeBB9jQU4wTRJ7TRMQljUXmy8V9NlTQxgMW2u2Ezfp88N0qncUx5JgKmsN1LOrewZYqsS0KZKErJ6hYGap3Ejfk2OS8Lo5symVM2HroIUHPkxJsm9x0oOpvBc+NKl1IrF8wSrnb8ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4H7jvs/togG3+26Ds/1XqTEtiHB5CxN8IOMuJN/PBo=;
 b=FaIGAQy+J2lg8/v89bqdc6pFUnN26At9W+tGOnrNdo161GvGPdi8uFboMXv+LRvRFtzkX5derVOfyLwA/wqJtg0XjisUJArIBioAF/rXQDZesZjN1STtuI70wWNemfenHPeln8VVSstIj4pkdO4nYtQRy6R547X/fAU68NinykHrMzZyTNSoXZDz349x5KrgAAAkp/8lT5mv/P3MaAMHSRw/rb+1Ktvfnd/5GVM8cXCRgqPO8xeFte69HM7auj+h9vvYFdKSDiQrBsa1ntonR5bOcjuYvm3PzlSWmds86Vi0C8g5ZOXcAnf502EIm9R+HYex/z4EviNSJHDVTPq0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4H7jvs/togG3+26Ds/1XqTEtiHB5CxN8IOMuJN/PBo=;
 b=TPPJWO+K2YmJuXIQySizy7VWquG9YLBK5tB3mUF2dGfSaeDg0oUrnhrtyRK6PwQiyYaoNP2xsPWaQheJGuto4EdKhjyI+DEIxBNBCtDgyMfqdbvNGWfufSG19OA0h4PNxpA+1iLPNBfXRtYs8OGss5Bt6/vA1N7ut3Of1el7aU4=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2480.namprd18.prod.outlook.com (20.179.82.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Mon, 2 Sep 2019 12:33:43 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b%3]) with mapi id 15.20.2220.013; Mon, 2 Sep 2019
 12:33:43 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     Robert Richter <rrichter@marvell.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] EDAC, mc_sysfs: Change dev_ch_attribute->channel to
 unsigned int
Thread-Topic: [PATCH 2/5] EDAC, mc_sysfs: Change dev_ch_attribute->channel to
 unsigned int
Thread-Index: AQHVYYqoelFrxSu3pkCoThr/UzCw6g==
Date:   Mon, 2 Sep 2019 12:33:43 +0000
Message-ID: <20190902123216.9809-3-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 8a5a06b4-4ed7-40ff-16ce-08d72fa1ca7f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2480;
x-ms-traffictypediagnostic: MN2PR18MB2480:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB248083C28DB32D986E62CEAED9BE0@MN2PR18MB2480.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:510;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39850400004)(396003)(136003)(366004)(199004)(189003)(6486002)(8676002)(186003)(110136005)(81166006)(81156014)(71190400001)(66066001)(6506007)(386003)(1076003)(71200400001)(26005)(6512007)(4744005)(53936002)(256004)(478600001)(50226002)(54906003)(86362001)(36756003)(8936002)(14444005)(52116002)(66556008)(66476007)(486006)(5660300002)(64756008)(66446008)(11346002)(2616005)(4326008)(316002)(476003)(2906002)(7736002)(76176011)(6436002)(305945005)(6116002)(3846002)(99286004)(102836004)(14454004)(446003)(66946007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2480;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: f++YGtZrtZ4HxfzSd5PROVdEKToYtqaTMw8FN+q16eolOZq/cgsLZzXg7J5WNDC5mZo18muXFEJBHW7OR/qP4VTN1b2qWctn1skCzob+iazGVcageAlaj6bxRcYPvD8jYIIJTmbdBDtyO//V44HnErrGUo0iPTSiNqhzCb7CgKXcvC8WcOWm46H2Y5K+dY8Ljh0jPbuvryTswnSAlukDofQ0kP+sUZ+1PUE43i8mFnAYctd7gsgaOhjAvTULhg2JOCfZT12EhlDi6XtoogLJdDF/3ZTfS+iWl/1WYRNFYgU3L8ClxA6qvy0K7wE16eiFLfkbzNaJa5ePlNDUYzPvyDJgXBqvDDOQvdhLwNUsaCffeIF/E4h0KAOiKV8pTKyU6yAyfrDlogUMvvTiQcyrj4S8uq/gDth10xvTd9EZN7I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5a06b4-4ed7-40ff-16ce-08d72fa1ca7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 12:33:43.2779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8m3m5jI2bbcRrzPMReQm7dSj4F3T+/onN0iLquWe7PKhKjk3uiZN5WoRatQ7IFREbBgTxt6T3X0+m8+8Fekigg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2480
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_04:2019-08-29,2019-09-02 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Struct member dev_ch_attribute->channel is always used as unsigned
int. Change type to unsigned int to avoid type casts.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 640b9419623e..4eb8c5ceb973 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -131,7 +131,7 @@ static const char * const edac_caps[] =3D {
=20
 struct dev_ch_attribute {
 	struct device_attribute attr;
-	int channel;
+	unsigned int channel;
 };
=20
 #define DEVICE_CHANNEL(_name, _mode, _show, _store, _var) \
--=20
2.20.1

