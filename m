Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21337A5616
	for <lists+linux-edac@lfdr.de>; Mon,  2 Sep 2019 14:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbfIBMd5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Sep 2019 08:33:57 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:36040 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731239AbfIBMd5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 Sep 2019 08:33:57 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x82CUi8f029655;
        Mon, 2 Sep 2019 05:33:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=uBmY5dTFsCXMaS7sGGYqtq3IuV82FYsBA6M+q41w5eU=;
 b=V44PZDywdOc3/QTu1YQ9e7Z19VpvvxskyvSmx3fOCxZ5+gUMEN9oOXh/kk4atOMD9jeq
 GlqyZnptm5IimO+2iBBwG0X0KpREWFaZTVtKpAxHdXMfRqqCGuH1mDQBw8QYBzF9FGMl
 Aw/0dMew++5rujXzX7t2UzrtnJF/+J828afyWrMNPc5/NBZQ2myQ918e+oCxDCxnm74j
 O7ArnDqHWkhrf8IhqAmUtKo1bnqMTafJ8uk7mK3DByEXJCgGX12BYYL/np9mSTMv8cYw
 3yxoEKoTI/nEeFjagqzUhUJvkOQYMJ3iZvGIBy/8fs8HIcuUtP24VXj+MNu6cRgpVRwF Rw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uqrdm6032-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Sep 2019 05:33:42 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 2 Sep
 2019 05:33:40 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.55) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 2 Sep 2019 05:33:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4DjnjzJCqcIQIsEksknoVHSzYBxW/1cGgBYJei3V4U3FSvHu/ptfCdfaoVI42T4DHQMTIhCp6RGVuYccCF4hfObAa62W8ZR8eOP7jf9/Acg3mPS0B+V+GEUzBGp9tJqKZCzZf3gglY3zSEMskbjl2Zde6MpJI6pl3ikS9+ytNN4RfZGeabAsApchdv8I4gul7j1wujdg7CPZHIzG36JYbRqryiqbwZjQah5P8icyXlf+xSMIhJ3tTHpRLnHh2a8MPYALwVrOYbzTe0Zjbf6QVLZbQYlM0lDOkG3Gd1CISPYd1UlpzyDaPLJdq3pKELwFDF+pnzaeBpBLZyajopNAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBmY5dTFsCXMaS7sGGYqtq3IuV82FYsBA6M+q41w5eU=;
 b=R35Qc8bBiw841a75KXJ7h1+6k3JgTDwCXHVdmywGDs+kJpoGTAL+nxkofpANi0ok+zOI9g2ApNLwo5S8F8pYxJfq7BpO+iIjmq6yguXCpCWsGU7UHgeFq2KQ9FJvJZV1fDUwHzE5ZkxScfT/axOZYWGo3JCNSC21lFnyIDL2XdVKLgrJPTmQxyOmL4aPjy7Pq9JjXIGZQweFrPISBBMet4p2jdkWXOPtWUY9uBXpW/sbDYQw5Jremu5c7BrfgnLV0EC5leYeR10veiRGokVYhRwmpwEpuz4RxPIxZ1SdJXGD2aD15Clbw3dE+bZ9dhi7pgBNW4m5u+k0/DSdRMFu5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBmY5dTFsCXMaS7sGGYqtq3IuV82FYsBA6M+q41w5eU=;
 b=QRPe4EqlUYBNft+jkN20YLf9WL0YNcp/tDWMVxox059bjwal6WtE/UvzK5F6jUNbT7WiklH1Kczg5dst384sonO06VD7F6U8IW4U24jnFxwlepQLa0CI192XPc5rvHYDhF4wwwXrEPYfWozQgHb7umuf/7JQf0+eVNwioZlK41k=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2480.namprd18.prod.outlook.com (20.179.82.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Mon, 2 Sep 2019 12:33:38 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b%3]) with mapi id 15.20.2220.013; Mon, 2 Sep 2019
 12:33:38 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     Robert Richter <rrichter@marvell.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] EDAC: Small cleanups and fixes
Thread-Topic: [PATCH 0/5] EDAC: Small cleanups and fixes
Thread-Index: AQHVYYqlHQakqotENk2zP2XSi91fOQ==
Date:   Mon, 2 Sep 2019 12:33:38 +0000
Message-ID: <20190902123216.9809-1-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: e6a59efa-e79f-49c5-c61f-08d72fa1c777
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2480;
x-ms-traffictypediagnostic: MN2PR18MB2480:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2480E215A937E8E23A22438AD9BE0@MN2PR18MB2480.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39850400004)(396003)(136003)(366004)(199004)(189003)(6486002)(8676002)(186003)(110136005)(81166006)(81156014)(71190400001)(66066001)(6506007)(386003)(1076003)(71200400001)(966005)(26005)(6512007)(6306002)(53936002)(256004)(478600001)(50226002)(54906003)(86362001)(36756003)(8936002)(14444005)(52116002)(66556008)(66476007)(486006)(5660300002)(64756008)(66446008)(2616005)(4326008)(316002)(476003)(2906002)(7736002)(6436002)(305945005)(6116002)(3846002)(99286004)(102836004)(14454004)(66946007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2480;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ae+XQIyfZLK3NZr3lsdnm6NBj93A3ddKHbOFBEnosE95HAG46oXNB/C+6322NM88/MR64cI6oFo4iz1f0E/XEDCgcMNGOwr8GQ6ecebVYPzBx5wKqRXQIBe5RevHqyNdi7zKJrsPqBV5c6YR6LUfVG0Fih46p7AwlZNB5m4cS2cQ9AHNY4edO51b4zPkSNcEcSpPr9q3OeRr15J0UERoQrLG/oxI5FrK7B+R9A7W5LBuIcSnzihyIZAklrnY84Libh0BHRVN6cJtCnRN/7lCL9kG7kaAzgmQxEumNp1yDqlyzGji+/Ux1E5L5fPZxgR5DxlPm5kbNxzH+U8YPMwDSH1TwyFB6tK2/W4KIhxYJ8IWURK1taWFpyCDE+iN3cGf604kaSl5UWBAuKAOFtzQ7N53oZF7gkzYBw36aTBNQHk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a59efa-e79f-49c5-c61f-08d72fa1c777
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 12:33:38.5406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z+0kMEaE8lwXSb9euXJ0lXUAF73GmvG/cVk+lagtCm2zMsBIVn05c32bHCxbaOGF13UwBMPNDos4ep/LJEeRqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2480
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_04:2019-08-29,2019-09-02 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

A bunch of cleanups and fixes for issues found while working with the
code. Changes are individual and independent from each other. They can
be applied separately (only #4 depends on #3).

Also updating the reviewer's entry as I will be able to do some
reviews for edac code.

Note that patch #3 is an updated version of a patch reviewed before:

 https://lore.kernel.org/patchwork/patch/1093466/

Some references to ml discussions that are related to this series:

 https://lore.kernel.org/patchwork/patch/1093480/#1312590
 https://lore.kernel.org/patchwork/patch/1093466/#1310572

Robert Richter (5):
  EDAC: Prefer 'unsigned int' to bare use of 'unsigned'
  EDAC, mc_sysfs: Change dev_ch_attribute->channel to unsigned int
  EDAC, mc_sysfs: Remove pointless gotos
  EDAC, mc_sysfs: Make debug messages consistent
  MAINTAINERS: update EDAC's reviewer entry

 MAINTAINERS                  |  1 +
 drivers/edac/edac_mc.c       | 20 ++++----
 drivers/edac/edac_mc.h       |  6 +--
 drivers/edac/edac_mc_sysfs.c | 91 ++++++++++++++++--------------------
 drivers/edac/ghes_edac.c     |  2 +-
 drivers/edac/i5100_edac.c    | 16 ++++---
 include/linux/edac.h         | 10 ++--
 7 files changed, 69 insertions(+), 77 deletions(-)

--=20
2.20.1

