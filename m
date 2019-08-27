Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA66C9E7BB
	for <lists+linux-edac@lfdr.de>; Tue, 27 Aug 2019 14:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfH0MU0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Aug 2019 08:20:26 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:19638 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727864AbfH0MU0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 27 Aug 2019 08:20:26 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7RC9xdr027173;
        Tue, 27 Aug 2019 05:20:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=3UJPLK5iNrLn8rhvgRovCgu4chfwXQ3C/kUoPWi56e4=;
 b=EQBC0OjD9W1sHNSykdq6MvDvSsg2A/lDRorKrwLvTJXRPDkoaalt7iptQ6HES1uJTBOc
 QYBhgj42sR699Gi7eXi/lDew/RB5ctC1/ya066wyCWTa/EqNQEn+Qt0xyVIAc5Jh+PK2
 qdfHv4Extq4Qk/gz4bbGd3EF+UetFrTbCyxOZ1CVIYeEB3mNEKq5eGKKSGv8rFznYOlP
 Yf/vwdHA+FSxAOaJX15CAbCZoN2lKVwWO97e6XiX1qHb51bf2nJS14BrMmK6wQgLxFWz
 f8zH1GTxX0SDbJOMf7LmQOD5nQq1eSKyVD7rbXXGpUTNLByNuk7GT2RqRvqwBgpQ51H0 2Q== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uk4rkjepy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 05:20:09 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 27 Aug
 2019 05:20:07 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.54) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 27 Aug 2019 05:20:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cavuI0fSmPu4NqiO0GTiUkjbRDaPwEoozdlf+o6XMRKMavNGVWOMa4XZW0TTcFe2WG59H7rMNzC//KnXByCZdg8UcfQOm2CRJcHKSklRttpjAWj34UabN6TtZanahlCy4c9+EW7ao+O2Tx1JF0AamGa4TGIvdETA5ld8au/3xsV5I8z2nD0VyBMmPCXi2UgSLWYL8gJZDGHts1jAyH1I/D4NH7K0js9boe4zV5rNAMaRRfXX9HcuxUY3bzoI3MKMHI3csjGudszqO5gC5LK8UA13PfaDC1kvaU/6YvLy6iW9gjH1wi3MR/n++/fx8QBMDO3i8JpJuvK7OWBfiP7ziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UJPLK5iNrLn8rhvgRovCgu4chfwXQ3C/kUoPWi56e4=;
 b=Ez960qlJU/5zUvxU4Z13d/gNjL9ISRXsIQVR6K8ArwrLXOLyPgpRMVenZOdvgRITmy+A/pz97jD9F2ccsb2zup+mTvJ2ZlUmFlEhHDK0Zn6zsT9gEknbFqx4wmFhgwb9v79FJDJBZAs7gOcPzMWtiEgoVDKsmPGYPfSUwyWsZG09Z3odHvhonQlfbwDgWqrldTUkAKW4IwK1ov59a+YOG+YQBH8fW+uE+cuFUSzxwIGzX0kvBMYQEaLHNtpbL/RWxJzZnpdtU0G2iw/VQ/MbXKz217Yi0uD/nLaXrLDJ/S2NVaSpN3oY7VOVcbVx2brkMLxYQl74hhpyn3CRb16PXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UJPLK5iNrLn8rhvgRovCgu4chfwXQ3C/kUoPWi56e4=;
 b=cNmu+PFhoUP65wrqFDqXE+15QyziB8yqhO2JaLoGG5Sa23lNbfhkA91/oNkOQkt+/Gy5GVJzqSvz4alnOTUQf+PvAcZXISykbNFozftK0yhU0bqQEalL8atHTcKHa/voPrCpFnRkiTFTBbsCRUD19ZaSP9+eBGkR+fimKhXIlTM=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2990.namprd18.prod.outlook.com (20.179.22.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 12:20:05 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b%3]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 12:20:05 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Jason Baron <jbaron@akamai.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Tero Kristo <t-kristo@ti.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 06/24] EDAC: Kill EDAC_DIMM_PTR() macro
Thread-Topic: [PATCH v2 06/24] EDAC: Kill EDAC_DIMM_PTR() macro
Thread-Index: AQHVXNHCQNXmlYryY0S3iWFUnya/Og==
Date:   Tue, 27 Aug 2019 12:20:05 +0000
Message-ID: <20190827121956.6kitf62spfbi7pdk@rric.localdomain>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-7-rrichter@marvell.com> <20190813145947.GE16770@zn.tnic>
In-Reply-To: <20190813145947.GE16770@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::21) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e82e0ad-3873-42c0-2b62-08d72ae8e457
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2990;
x-ms-traffictypediagnostic: MN2PR18MB2990:
x-microsoft-antispam-prvs: <MN2PR18MB29908055C73840BF9BD14205D9A00@MN2PR18MB2990.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(189003)(199004)(54906003)(1076003)(305945005)(476003)(6436002)(486006)(53546011)(316002)(5660300002)(66066001)(3846002)(26005)(386003)(4744005)(7736002)(14454004)(53936002)(6486002)(186003)(11346002)(446003)(52116002)(76176011)(102836004)(6116002)(9686003)(25786009)(86362001)(6512007)(478600001)(8936002)(256004)(71200400001)(8676002)(6246003)(81166006)(66556008)(2906002)(64756008)(66446008)(81156014)(229853002)(66946007)(66476007)(71190400001)(6506007)(4326008)(99286004)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2990;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cgypWYzqBZBjsujBn5onJxXd4DAeFCa60PB6F2TDW4nakzw8SfEZbMa4ETxMFKD1kCHAhvw2EkrntoBdfKb0mNH66ajq0oQjSSXlfHls+R8zqLEopMyK+t7AsX/MahduGiDCYHsUK+bnD+J0cP+nYu1eeSZgSr4tqLQW1IdCLyH07ULDVgahOi3SRJXx5Yz6QtM+we0ojz6w5eWIhUG0gG/JpSCms5mtbVLz7nqyPiNi5mq20BB9fivLVGrYE6JfPt5EeeY1ZDD8Xf1ZqncaQ1jAAabfIY6tjtOUWGgO3PUpNfIDce8OQkXhPrFINZpIrMe9DLebvrF7oU+gPsupsXxrVd4gTHEGixdknq9NPXtTiLhv6np7prvBYeIf8Bu84jbSvMUNU1pURC3UMcUR5s71chJVBSiEfmsvOob9IuU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D66A4FE408AD8348AE47360DB7CAB60D@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e82e0ad-3873-42c0-2b62-08d72ae8e457
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 12:20:05.2279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GCHFqDYJfDrSLJ5FWo9IuZ2aCqF8GrZrTaAnZbBPJJS58ejTu5os633GzXzK+cXS3HtGFhPZz6PEVgBub8xwUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2990
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-27_02:2019-08-27,2019-08-27 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 13.08.19 16:59:47, Borislav Petkov wrote:
> > + *
> > + * For 2 layers, this macro is similar to allocate a bi-dimensional ar=
ray
> > + * and to return "dimms[layer0][layer1]";
> > + *
> > + * For 3 layers, this macro is similar to allocate a tri-dimensional a=
rray
> > + * and to return "dimms[layer0][layer1][layer2]";
> > + */
> > +static inline struct dimm_info *
> > +edac_get_dimm(struct mem_ctl_info *mci, int layer0, int layer1, int la=
yer2)
> > +{
> > +	int index =3D layer0;
> > +
> > +	if (index >=3D 0 && mci->n_layers > 1)
>=20
> Can layer0 be negative here to warrant that check?

Yes, if a mem controller can not determine a dimm's position, this
function can be called with layers set to -1.

I have reworked the patch according to all of your comments.

Thanks for review,

-Robert
