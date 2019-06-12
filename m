Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A971E42D4B
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2019 19:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407077AbfFLRRR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Jun 2019 13:17:17 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:51642 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726696AbfFLRRR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 12 Jun 2019 13:17:17 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CH9rhl017510;
        Wed, 12 Jun 2019 10:17:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=hIK5zeP6ao2b1ZepQY4gzhzpQIw6ha3c1sMnlMa7aAI=;
 b=Ybo9Z8FZJT8wGMoFLnIuHQwgROBDIu/gQwdHb27Qnf7PLcIswzOgVGPxLAudJfFRjQ+Z
 YgCLqt6YiqOIjRS+o5g9c2UGpBq78zEWynReRSyV52Yt/eIOr88CS3zLUmPH8UAKcDU2
 ybSLMEHkJObVZei/1LKuLbXDM2rqkhtViINKs9dohZqGe6cllXS57qLvPU+42M/KAszz
 qM7YKHYKtkScn5GCToao7QOkGj8NKLUmf/wtJOwviSgA1vFAfQFMeuUaBZxDWMfNVhSH
 FeGzYTcUgjLjA3OsM7aQwden2suaga0LRp+Ie/9gdSVoL6UkvboZfDMPoiqOH0fp/sLw 3w== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2t34b50d4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 12 Jun 2019 10:17:05 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 12 Jun
 2019 10:17:04 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.54) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 12 Jun 2019 10:17:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIK5zeP6ao2b1ZepQY4gzhzpQIw6ha3c1sMnlMa7aAI=;
 b=pxLnHIUhjWwwpNWF5uQzL/0G4UdjS630mUE/X1f9CQBDMAjeqKeGdXMLFx3kPWwj0A08vF3MN70JzbpQmnlt6CKTMSCew8bzo+j2N8lITjOn3CfRU11+efK2wviTCCQkdPAYyZqCBgAtyD+AUXgGaozpmyp8E5NKBdneVT6YG/w=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3040.namprd18.prod.outlook.com (20.179.84.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Wed, 12 Jun 2019 17:17:02 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.1965.017; Wed, 12 Jun 2019
 17:17:02 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/21] EDAC: Fixes to use put_device() after device_add()
 errors
Thread-Topic: [PATCH 02/21] EDAC: Fixes to use put_device() after device_add()
 errors
Thread-Index: AQHVIUKmhiTy8LR6DkWXpxinM3HGfw==
Date:   Wed, 12 Jun 2019 17:17:01 +0000
Message-ID: <20190612171537.mdhs52ipmvfotgdh@rric.localdomain>
References: <20190529084344.28562-1-rrichter@marvell.com>
 <20190529084344.28562-3-rrichter@marvell.com>
 <20190611172830.GI31772@zn.tnic>
In-Reply-To: <20190611172830.GI31772@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0191.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::15) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.254.182.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c4af39d-d1d6-4e06-7fbf-08d6ef59c811
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3040;
x-ms-traffictypediagnostic: MN2PR18MB3040:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR18MB30408161958775F63C8913D7D9EC0@MN2PR18MB3040.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:159;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(136003)(366004)(376002)(346002)(396003)(189003)(199004)(8936002)(6246003)(99286004)(6116002)(316002)(6512007)(53936002)(3846002)(2906002)(6436002)(9686003)(6306002)(25786009)(68736007)(4326008)(102836004)(52116002)(1076003)(229853002)(4744005)(6486002)(81166006)(81156014)(966005)(54906003)(305945005)(478600001)(7736002)(8676002)(476003)(53546011)(386003)(6506007)(66066001)(66946007)(73956011)(14454004)(5660300002)(66476007)(66556008)(66446008)(6916009)(64756008)(76176011)(11346002)(256004)(26005)(186003)(486006)(446003)(86362001)(71200400001)(71190400001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3040;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 29W1s/iPq/NDP0q4SggSVU7swrLqeUKkv9jGjC/9ChcyqfSD6VTguwGkfTwrcDOFH6AGttPnZtyRYa/kcd4DY5M62YsUcrOYejJfdh1v7cNWTxx4BEr4bgUFmltHBGinZJ4QjJ4rd+xBqA2/4vS7UnKsUO9RLZ2jPm8MNasnKf2mlGRsMIqFOVCu8pRtkihdauTyFbz7zQp5zaMSupILHssz6GY8xzN8Oq0FzpWzE5/qLCW3QBRyiXuaNcOh55zaJJlgoyCx8sT04T6CF82zMMjBYuja+9Y1T9dbypPVY9lSMc1pB6SgNLqYikuzA3aaNaCHscHYYqN+tkoiHwq+SRXoVmefoZLoMRB35y+herId35qRYBfevPhIBWazAY6Sxu8F3Y/4fJDrJKGkh9BbmMAv3g6CZIyoQZ3t3bTw/Hg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3336DA8E6341AC47826BFD140727F400@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4af39d-d1d6-4e06-7fbf-08d6ef59c811
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 17:17:02.2423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3040
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_10:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 11.06.19 19:28:30, Borislav Petkov wrote:
> On Wed, May 29, 2019 at 08:44:05AM +0000, Robert Richter wrote:
> > Always use put_device() after device_add() failed.
> >=20
> > Signed-off-by: Robert Richter <rrichter@marvell.com>
> > ---
> >  drivers/edac/edac_mc_sysfs.c | 36 +++++++++++++++++++-----------------
> >  1 file changed, 19 insertions(+), 17 deletions(-)
>=20
> I already have a partial fix for that, you can send me the rest ontop:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/commit/?h=3Dfor=
-next&id=3Df5d59da9663d115b9cf62cce75a33382c880b560

Ok, I have rebased onto for-next.

Thanks,

-Robert
