Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56F75B8B40
	for <lists+linux-edac@lfdr.de>; Fri, 20 Sep 2019 08:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404593AbfITGt7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Sep 2019 02:49:59 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:40892 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403959AbfITGt6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 20 Sep 2019 02:49:58 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8K6jYRZ015484;
        Thu, 19 Sep 2019 23:49:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=XLEEbJ0/H+QSuLwssREOhaf/504LOqI6+G3xPsfWAjA=;
 b=XCdvMWtkQGut9NMap+4vUH5UTbHjKT146CQ++YhitC2V/ijBYJJNrBPD8TbiCw9c0yfE
 P+4DJpa4Vsihb8Ql95HjT+OdAeJzErbqt6is7FWE4XGk1Li7/4abDHE0p8ut8qLbER7J
 CRicZGNvrapZu+LHw2o1U1bIXkAM0FQtcdvWT2N+G8rp1vn8H/QtN0rfU+Arc/OHKSVS
 ZEnIG4aE5ALy3O0/tzlxJEoQLNe7+WRvtZHDAa8Qsx9/oc1WYMfnkeg5k4uDfyuL3+n5
 eKqOiVVTycdCZf/zy080mPI4+EPyJmP9n5Y4pnItPG5xHih7r1ox7WUlk3BjM1/LmUUT cg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2v3vcfpyt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 19 Sep 2019 23:49:50 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 19 Sep
 2019 23:49:48 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.54) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 19 Sep 2019 23:49:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfGRttUWaGSw7zRGx/NYztW2nTiqln9wpl9/RezO56PgJDLw1Y8kYKKQ8ADkdkcSiNtrEjj14NGbX+0PC9jEAVVGpsJF14crSwbSjA3S3f+KHKxz1vClRLD2z7ItHYGS6coH/GfRcVqON0gEUHIOCvxDobRWB1MJV6d8XQWu6vJA20drDWyqcSrgjfvWkxo5BOKMxkyJ05zS4DNDuo518WdT/FFxZy2GJsQ/oCaSZraOKZzPvV6fenivEcAEBw1RZ33J6NY0HtqzywPaEw5YUTYeU7mXVRvsw/mpWw2i97wgjEXRVDMUi34P2QMBN372mxlX6ktywxkAe2f+CkVetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLEEbJ0/H+QSuLwssREOhaf/504LOqI6+G3xPsfWAjA=;
 b=mslC6Hb8jCvPRBAvfI6kWQ4wN61e+mxtXvq2vizfPdawPdiyoE4EbdHwZlD1rhUn/QqCPP41whpxnIvSlBNabQaah4i4hl7Ai0PmGuRbrGsFM0+yJj5QVmM3TxilIVEhhAH5lZGtCftlBRZV5HnU/GLktuXtaQjKTFlvZ0SoBmUu4rtw0ZKQhYKGyvUJAk+rx2lO77YTCOJQzYr1scFwggsi6Mb2R08bpCiFm8P2cLCNTHfDD7pH3iSLOEvhbjLaTM0+Qu01TLlctUXd31O3BosYezCoOIE7Sc2xM3CcOsELmYvSyve4M+HwFsAy7iD3bl7dNjx3NBnZHIiA9CSbiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLEEbJ0/H+QSuLwssREOhaf/504LOqI6+G3xPsfWAjA=;
 b=Q+63ldO+AaOawM/7HJIEG6A808PFhDRzShyKEw299dqarF5fMk/R3QQxMNu2SFcbNRSfFh0odCloMd3a+RWSsc28avfBreRYhmLpDCfMUb2h8OOKKsLIs9sud+z4UNnjr30JqfIvyRE8YorQ7KM7OP38UPvo4TyLd6aF0dBEXAk=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2432.namprd18.prod.outlook.com (20.179.84.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Fri, 20 Sep 2019 06:49:46 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b%3]) with mapi id 15.20.2263.023; Fri, 20 Sep 2019
 06:49:45 +0000
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
Subject: Re: [PATCH v3 2/2] edac: move edac_device_handle_*() API functions to
 header
Thread-Topic: [PATCH v3 2/2] edac: move edac_device_handle_*() API functions
 to header
Thread-Index: AQHVb3+WHFNLttAdVEqF33Cg+Ln7bQ==
Date:   Fri, 20 Sep 2019 06:49:45 +0000
Message-ID: <20190920064937.owwv5n663kwmnbb7@rric.localdomain>
References: <20190919171713.8060-1-hhhawa@amazon.com>
 <20190919171713.8060-3-hhhawa@amazon.com>
In-Reply-To: <20190919171713.8060-3-hhhawa@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0137.eurprd05.prod.outlook.com
 (2603:10a6:7:28::24) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d508bdac-309e-4ee6-1418-08d73d96b920
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2432;
x-ms-traffictypediagnostic: MN2PR18MB2432:
x-microsoft-antispam-prvs: <MN2PR18MB2432B1D36757C687E86D03DDD9880@MN2PR18MB2432.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(189003)(199004)(66066001)(3846002)(71200400001)(305945005)(71190400001)(186003)(26005)(7416002)(316002)(4326008)(6916009)(7736002)(102836004)(6506007)(256004)(53546011)(66446008)(64756008)(386003)(66556008)(66476007)(25786009)(66946007)(9686003)(6512007)(52116002)(6246003)(76176011)(99286004)(478600001)(81156014)(486006)(6436002)(86362001)(2906002)(6486002)(14454004)(8936002)(8676002)(81166006)(476003)(229853002)(54906003)(11346002)(5660300002)(1076003)(446003)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2432;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QR1SjkToGuEiKsZ9x7cpAKgkpFg357jIQ58w5p8ytQE0HjplAjeEjXokZEIbR/Pqa/tqb1hYLhw7063yr0fP+XV0lr9iXEoUaigQLO+Cd9rxdij9J7bCeAyBXKmPJ5yfy+9riG2tWhCxDbEHzGpog1U/doQEKnw6sR2Jtbb9laU8F/MGkG6CmOCG7/bPIVcony+CtnsIluy1k5tcYDO7OzIwG+0LrLendqseDdfRYlHpxT09UfmNu1vD7e3X5CpjD6eWr8B4tB/ZzB1WqHyYCNP7eUXc0FZsUzv85bpFDBueE7n4u7cWdX6wGfG8uIouxHNSNazIUzujFgdDq7dQNeUSAp30qTxyHLGFqao3i9xrLOXDcV0BwnzQWdvi94tTqGMDnO+fIAAXGsi8VxGUj3YRGZXnw6YAZPfUAu8mpuk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0302A7159C9B82458BA77E0CB1092993@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d508bdac-309e-4ee6-1418-08d73d96b920
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 06:49:45.8259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6x+JgOqrWH8u6pod+368Pm57PQ7jm53Kf/hun0rwH3tqs8wuX4cbt7H3GLDOX6Wuk6E++28EoVM43wrqOvu3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2432
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-20_01:2019-09-19,2019-09-20 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 19.09.19 18:17:13, Hanna Hawa wrote:
> Move edac_device_handle_*() functions from source file to header file as
> inline funtcion that use the new API with single error.
>=20
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>

With the changes below it looks good to me:

Acked-by: Robert Richter <rrichter@marvell.com>

Thanks,

-Robert

> diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
> index 30dc5f5979c8..796ea134a691 100644
> --- a/drivers/edac/edac_device.h
> +++ b/drivers/edac/edac_device.h
> @@ -285,29 +285,6 @@ extern int edac_device_add_device(struct edac_device=
_ctl_info *edac_dev);
>   */
>  extern struct edac_device_ctl_info *edac_device_del_device(struct device=
 *dev);
> =20
> -/**
> - * edac_device_handle_ue():
> - *	perform a common output and handling of an 'edac_dev' UE event
> - *
> - * @edac_dev: pointer to struct &edac_device_ctl_info
> - * @inst_nr: number of the instance where the UE error happened
> - * @block_nr: number of the block where the UE error happened
> - * @msg: message to be printed
> - */
> -extern void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
> -				int inst_nr, int block_nr, const char *msg);
> -/**
> - * edac_device_handle_ce():
> - *	perform a common output and handling of an 'edac_dev' CE event
> - *
> - * @edac_dev: pointer to struct &edac_device_ctl_info
> - * @inst_nr: number of the instance where the CE error happened
> - * @block_nr: number of the block where the CE error happened
> - * @msg: message to be printed
> - */
> -extern void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
> -				int inst_nr, int block_nr, const char *msg);
> -

Just put in the inline replacement here.

>  /**
>   * edac_device_alloc_index: Allocate a unique device index number
>   *
> @@ -357,4 +334,18 @@ static inline void edac_device_handle_ue_count(struc=
t edac_device_ctl_info *edac
>  {
>  	__edac_device_handle_ue(edac_dev, count, inst_nr, block_nr, msg);
>  }
> +
> +static inline void edac_device_handle_ce(struct edac_device_ctl_info *ed=
ac_dev,
> +					 int inst_nr, int block_nr,

No need for this linebreak.

> +					 const char *msg)
> +{
> +	__edac_device_handle_ce(edac_dev, 1, inst_nr, block_nr, msg);
> +}
> +
> +static inline void edac_device_handle_ue(struct edac_device_ctl_info *ed=
ac_dev,
> +					 int inst_nr, int block_nr,

Same here.

> +					 const char *msg)
> +{
> +	__edac_device_handle_ue(edac_dev, 1, inst_nr, block_nr, msg);
> +}
>  #endif
> --=20
> 2.17.1
>=20
