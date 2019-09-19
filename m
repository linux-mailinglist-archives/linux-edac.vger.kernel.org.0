Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3819B7330
	for <lists+linux-edac@lfdr.de>; Thu, 19 Sep 2019 08:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388162AbfISGd7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Sep 2019 02:33:59 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:55672 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387712AbfISGd7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 19 Sep 2019 02:33:59 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8J6UCLK028225;
        Wed, 18 Sep 2019 23:33:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=4mqZp6U+gujPwvNE+V7xqd820tX8bgcDltznrvgn9Xk=;
 b=VXzNLqdFPD6FDI74lt0LNnURm3rCsoyGch3V2By9He2O09MyRkDCpe/egeoMKpBVJaYY
 rTHdLSADVlIJhFyXc7/GLIphFEq2ZbKEgTeJAnsNNiHH8ChkWs+iu1YhX+34gSeJQnvz
 6+cE1wu8YA+2uh8StYKNExzlQQSA066chLv0O9iNGJ24wgY6cSkqiptT2nMIgdBFKVKm
 dvmG4kMiWTBu5VHP/IFrQCMlFBYYkPDqu+7zTL0zGHBnAytXnDXC7z56w9t+XcO3KJ1y
 wcHAQ/tq8uu1HfKoen1O7X+rCMf2DEQRDsxNFD/abRc6tFtx5NHUFX0NvX9Z0W7kEMDI qA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2v3vcfhkm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 18 Sep 2019 23:33:45 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 18 Sep
 2019 23:33:44 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.55) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 18 Sep 2019 23:33:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4TFW00iXXjnAU5uCJYbHYT4dllHgsd/C5HTzFrO44g9D5SzaB6udfM1yZ6qqrkR548Zokn+0wr5/OUH8tx86svYHKivBtuup6KOlIXO/C65Oj3wD7aWnELCPBN85dokxjfLT237gjYN8CmtOXNUy+FlZ0BVgXMfj3jdqOMNbd6YXvRiWv3ePux5DvjTIT4mvI7GSMRXA68PupyxbQVuqe3bE3TGpPsnUaR4tSDFoYB/Ay5wYaZHz2YxYe8gT9kJb1yJY5+IEHiIFlFdDkvGHMnc86Ai8VRccYKhfP29cj5PLONnevDWHMBbHkqnIxT0S0ZMr19Cs3Kv9UX96DH6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mqZp6U+gujPwvNE+V7xqd820tX8bgcDltznrvgn9Xk=;
 b=T+8DGSXBmJdd2LncWlWwiZ8/CVali6ltO2zNVchgCUE1xk3ModD2ceRsFulECtBTw7v2ZYLfp/C197oq+/opF2USoG/2K2WPw5/cQf4Jyqlbb0JKipuGx04n/cl7vjGWCo+zdwNrjlc0mL7Ol3WPpJWrIgActLIiiyJ0N9gNyOxLQHTOhI+xRK3uFadcGClWGp8qmXcMa8yK5l+z+69SilSliaPV1lJzwlKhqNN9t+nBeCBegifEHlHr9saupxPBd4cvLzEQ9UXxoOQUvI7UOjH23MhNxeJ9YsFopQWTJeHodCOzx/qCjai6FBVn/jlUE++hiQ5A4Ub8/fcBecvpMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mqZp6U+gujPwvNE+V7xqd820tX8bgcDltznrvgn9Xk=;
 b=K8k+CKuyPezVc/oiNDiUaDeXhDBR6yuldiayfqfLKBsAHpY7dTuYtZ4ERr3fHEgP9X/v5qaAgEG+tLBxzkXKn4RL+MRUA2AByANSk9NMMxN3z+xKCNyxDJPbUzeXrKmVrEkwcDLKSzznnFF/43iuJQc6M4GP2AzV3hAyF1rS0Uw=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3328.namprd18.prod.outlook.com (10.255.238.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 06:33:42 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b%3]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 06:33:42 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Hanna Hawa <hhhawa@amazon.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@amazon.com" <benh@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>
Subject: Re: [PATCH v2 1/2] edac: Add an API for edac device to report for
 multiple errors
Thread-Topic: [PATCH v2 1/2] edac: Add an API for edac device to report for
 multiple errors
Thread-Index: AQHVbrQuVYp3+gdDsUucx/uYgcDYxA==
Date:   Thu, 19 Sep 2019 06:33:42 +0000
Message-ID: <20190919063334.x2rfk33swyjqur3q@rric.localdomain>
References: <20190912145305.21008-1-hhhawa@amazon.com>
 <20190912145305.21008-2-hhhawa@amazon.com>
In-Reply-To: <20190912145305.21008-2-hhhawa@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0220.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::20) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d2a81a4-15fe-4833-d7be-08d73ccb509b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3328;
x-ms-traffictypediagnostic: MN2PR18MB3328:
x-microsoft-antispam-prvs: <MN2PR18MB3328E7B8FA7AA40D4E9D2408D9890@MN2PR18MB3328.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(189003)(199004)(86362001)(6436002)(7416002)(9686003)(66476007)(14454004)(486006)(6512007)(66556008)(6486002)(52116002)(256004)(76176011)(66446008)(81166006)(81156014)(66946007)(2906002)(64756008)(229853002)(478600001)(4744005)(53546011)(99286004)(386003)(6246003)(1076003)(6506007)(8936002)(4326008)(26005)(7736002)(305945005)(66066001)(11346002)(476003)(25786009)(102836004)(5660300002)(3846002)(6116002)(186003)(316002)(446003)(6916009)(71200400001)(71190400001)(54906003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3328;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TdscTdLt6jhcQAVrBJ8O9K/x340FNpdFm+0+yiImJCEoxfAUuiCeKhc/eKjdeLiG93NQZrS5fDzMeUbq5+6j7R/lH82PgLGUw+0rQuR5HwG0jWDQeMv9Uvhx9cQY/4O1PpKJmMYX8BNdb7VzzfaK3elJ+Tm72epBqkdSs05oPqFmdpqtQXminuoQnDD+L/r67TwzqidFrBSsoli6Pmhdw45w39Vc3aZDmg92gT5C5FE/HoAH40Zo3peWBL+2FQ0Jfkt1+uF0MPrRY2u/L4KSCQ/1fAPuWefVQ1Pxtz57zBFJ0CaN7FvuLhr7cOUXWo2ekcOeKWlemLmX/UmpkVUz6gqkjw3xgj0KPFIqsTuo9XRLnRjq+lWbd5pTIcR/B+9K7Ktoh0nRNwK5tMvhn4+2iErXeSrrTR+iQwNMp06ZVbo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <149A30E28A77A04BB6CEC51434FF7CB6@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2a81a4-15fe-4833-d7be-08d73ccb509b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 06:33:42.6181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7YR87Oy8nqytHLLqRH1m2Clm7wbSrYijEUpCqO+Y+h1HzkeIuTsyi/4h2QQyKEYyDHnnWTqQTBrWiEZc3b5hiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3328
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-19_02:2019-09-18,2019-09-19 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 12.09.19 15:53:04, Hanna Hawa wrote:
> Add an API for EDAC device to report multiple errors with same type.
>=20
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> ---
>  drivers/edac/edac_device.c | 91 ++++++++++++++++++++++++++++++++++++++
>  drivers/edac/edac_device.h | 40 +++++++++++++++++
>  2 files changed, 131 insertions(+)
>=20
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index 65cf2b9355c4..78ac44103acc 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -643,3 +643,94 @@ void edac_device_handle_ue(struct edac_device_ctl_in=
fo *edac_dev,
>  			block ? block->name : "N/A", msg);
>  }
>  EXPORT_SYMBOL_GPL(edac_device_handle_ue);
> +
> +void __edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
> +			     unsigned int count, int inst_nr, int block_nr,
> +			     const char *msg)
> +{

Please do not add a copy here, instead modify the existing function
and share the code with both, old and new functions.

Thanks,

-Robert
