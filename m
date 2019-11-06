Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCB8FF126D
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 10:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbfKFJda (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 04:33:30 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:27414 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731673AbfKFJd3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Nov 2019 04:33:29 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69UNGM002538;
        Wed, 6 Nov 2019 01:33:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=BwXLj6insvqCGInDaPqtbbjZNtDoe7WJv9A9oT07o3Q=;
 b=EvlZt1mJ7KMKnZDRQjCnFJjPDJRtFCUpHGUWJCnoGLkFBWf5my2cGzxicguqbtwFS3Zq
 yWJy4r6PhYZzMVaSJcUZArQ+9dU3GqsldnKrf2paABJXOslbuP/PxZOwF80zjHapmAS8
 cQe3uyvkpbTrymf8Vk9R4yXuEoYyorTp8J7of7eQznOvubkIvg9EUwz8egRQp79D5gEV
 qxQZAgjL/68xlay8ztOs6C1MBYDp03Gsodu8VaBwWY8GTA0+KBYgMmhlP6Khusym2z9l
 gPW/i1cAMevyZIdL7rQChvUXNLWvZGhcZbBT8HwRGkzmCxioNtqMXQh2PMDdV/czVNjD pQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2w3eud3c7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 01:33:22 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 01:33:21 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.57) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 01:33:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z60i9NsFh/VO76d6YU+K2f75/D/U5jXzvElhSFwssp+EL+AokFUgtlPYb6CC8RyJYv0i7jWmADfG6hICfbpfDBWS7SEpX9oWN0toG/D/RC0+ZuSwMlQHP0TdgETkCO+G9bAAhGSxyQduaMZwkNzGrd1U7NBQFq1626fdBtNAKZW/6RkabS+/H42hWiFccoArypSNsalqkrZ23iJdctXR4cWegJ5lmheRkTaBC2VJl/XJer4egvnoVrv+XExVBkC0MG6Ex+CLQzCOWJFIlzDY+X34/JEaXX8fkH29dyxks6CwglueoPZQqN18LCef7wwdQuqJ7RJm6LMN/MiFURixEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwXLj6insvqCGInDaPqtbbjZNtDoe7WJv9A9oT07o3Q=;
 b=Qdgs2ffJY6YYqYR+k0nXXsY/eIsSCl8FX9EWkY2neO4YooTBdPI1YJoHP5j/Za0PRCsbedhNmGOcvpGpNu6jdFPKgJcED1RyAzf8w7R+KlNGedpwXFByjSdmYp1DYDDulyxpckh4gTQ/N3D8Fn0+uezOL4FrB8K5JprxeQDc8VbaXZq9scfSTgJtn2bgYLSFsTPp/22WfAUjRcJBr5FpHkESMOAvrF83427J/4SB/8ghxp/dMbZ1PfMKFTn5C0eM1toF3el6IoelB3idiYQcJdT/qxZju/4RDXpxoMV5yu6MUqd4noKvmCKxRLTTi8F+Fo0iWFyN4KjIjIFFy7RJcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwXLj6insvqCGInDaPqtbbjZNtDoe7WJv9A9oT07o3Q=;
 b=XFeOBuiAmi0GqX5RT3iD3/xGFLI1FfpDLb8AXmaVtfSXhXJap0In/KZzP0QJOeNaDZg1G08kaDmWhzi+4Wjvxcc6RQ6l7rC2J9EtOHuTKNvGXUm35PMmGW3mJnId7Iwh8LtzwoMRRm6mrm3tY/g2ZvaEuAlL7rCEP2w+piMbPRM=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3165.namprd18.prod.outlook.com (10.255.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:33:18 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:33:18 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Subject: [PATCH v2 08/20] EDAC: Remove misleading comment in struct
 edac_raw_error_desc
Thread-Topic: [PATCH v2 08/20] EDAC: Remove misleading comment in struct
 edac_raw_error_desc
Thread-Index: AQHVlIU55TRYGs3MD0igG2O9hLwARw==
Date:   Wed, 6 Nov 2019 09:33:18 +0000
Message-ID: <20191106093239.25517-9-rrichter@marvell.com>
References: <20191106093239.25517-1-rrichter@marvell.com>
In-Reply-To: <20191106093239.25517-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0287.eurprd05.prod.outlook.com
 (2603:10a6:7:93::18) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6571ed93-312f-46e7-601c-08d7629c5b5e
x-ms-traffictypediagnostic: MN2PR18MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB31652FEC04AB776AB513FC20D9790@MN2PR18MB3165.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(52116002)(305945005)(6486002)(4744005)(76176011)(71190400001)(71200400001)(256004)(11346002)(446003)(7736002)(6436002)(4326008)(6512007)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(1076003)(476003)(6116002)(3846002)(110136005)(54906003)(36756003)(2906002)(8676002)(99286004)(81166006)(81156014)(316002)(8936002)(50226002)(486006)(6506007)(386003)(102836004)(66066001)(2616005)(86362001)(478600001)(25786009)(186003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3165;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ndQPSKuDFhrYlqtjnLfr9f9fyiXGqqSDh1If3A5dSj4oh0RBtY6XezktrvwW7C7UMq+PFkE+zv5DWomSb4ws6gv/wqc4gfc8wJGx7ZhPdgqi7EILeI351raUr5xgQ94BDM0QKJ0aTqN0a9YvWOaFm1rT7WKNB7TPm22FSF/ZilZ7IRhWV3FlH+FnKw3/KF2g2lw/J+xHcaCSzimjgD9MvYrx2zJibPpdwhFC6h3U8CSLeTqleqgDQXjco/vMptFOZOvTefw+3ECRPBbCM97G4agj+TCxJygqBPUGNwvQIHSreuPdn/1GaRvUKC1UhHx7iFKgW+5IsdrDbsRwr06oQ0Y8zEu8PXrsQCEPddq7r14SmqQ7xHYgYrMgqTql7Kby4OjYfADxns8KxLlA9G3atOYzGFti6LnljeCFuPzdLCbqB2+qKAMRCJTymLMu+FGI
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6571ed93-312f-46e7-601c-08d7629c5b5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:33:18.7244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 23tGE03uKb7dc6iQ33DhwTH0rbLVUVLVFI4RcFUrF19zxPehAVBJZyCXOHmcgpSd9WfZ3jiNIdl/OGu+J5S0tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3165
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

There never has been such function edac_raw_error_desc_clean() and in
function ghes_edac_report_mem_error() the whole struct is zero'ed
including the string arrays. Remove that comment.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 include/linux/edac.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/edac.h b/include/linux/edac.h
index 8beb6e834be9..67be279abd11 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -457,15 +457,10 @@ struct errcount_attribute_data {
  *				(typically, a memory controller error)
  */
 struct edac_raw_error_desc {
-	/*
-	 * NOTE: everything before grain won't be cleaned by
-	 * edac_raw_error_desc_clean()
-	 */
 	char location[LOCATION_SIZE];
 	char label[(EDAC_MC_LABEL_LEN + 1 + sizeof(OTHER_LABEL)) * EDAC_MAX_LABEL=
S];
 	long grain;
=20
-	/* the vars below and grain will be cleaned on every new error report */
 	u16 error_count;
 	int top_layer;
 	int mid_layer;
--=20
2.20.1

