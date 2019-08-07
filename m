Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E66BA84852
	for <lists+linux-edac@lfdr.de>; Wed,  7 Aug 2019 11:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfHGJBJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Aug 2019 05:01:09 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:19136 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726498AbfHGJBJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 7 Aug 2019 05:01:09 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x77907Qc025138;
        Wed, 7 Aug 2019 02:00:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=NIPQXsaf/SP718cKpLwy1xTHWu2XRxVgRWTteWA6iQI=;
 b=oy0YgJ1N8ExdkCO9Y2ZtQGrPrf/Ya7cazg8/eftGS+KpH0ebpcFE1zhZTdaVYq2DVX/g
 QP2C34o+u3NgRfxXwmVriZjSz+8aCnBywXKsiIXMvzP43yk83q3eeFYSEubPJF6dw5Rf
 Y1KM6xySo723TeHqm94spj7Vbc3LnQZ299iSRzb4WU/LvxaZNH2FTEYpTu1MuMkECN+M
 zTcuSywJHMBqFiSccBP4djejt3RX/R0jPuL7nKzPfMsa9U8sU3mZcMwgmL9M0vKWwi+N
 HRpVuMYIWa86lBid2/FMEQf8Shqtr41arutS/fYARvOZ6CpOUHWWdaFHmqYRnpA5RwsX XA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2u57mr7agn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 02:00:56 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 7 Aug
 2019 02:00:55 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.51) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 7 Aug 2019 02:00:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkc92ylwsXTAyoYQTa2EVmQDuf3zzFkBOZQFCLav7xUKGarEkZhSvuHV5zdehvWObA+vsmO/0z2JyYrj1IDrxnnkkYg55jh73xDI3ynhyqD1optTya7A+WYDhRX+hoEQCV3QaRQ7oz6vSYtVatqwyXTctoqZPbDjF5f/XxNxyHmNFA8bHgV4WKtxthLLgZSYXOXNNcCCS2tKem9qgK+8StD9enOOm9tgU16BhFACzap2Oa2omMVOVm6CzYdqD8EPCpP6zxeRGG27Moc8Od7VYfkn/rO0tj5/13uayB82F2eb8hqLGEftEOGByA/7g29eKYs8UxjAieNBzQVoJ76vzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIPQXsaf/SP718cKpLwy1xTHWu2XRxVgRWTteWA6iQI=;
 b=P8lEPqg7phWaKOcuY6Q3GtI1HHAyZBW2F4uwEWN+NoXqunzFV6FiTw2K3Cvq3pJdOacjydZ1lLgZiL6mv1JIRckD6ObcfI81uivfOVas4Nd+AEH5GkgUHZwD0Njgkqr1LEUlxNljSuuz8J02XEM5KESmHy+WMAqz7Zr8dFAORxn/9/URQbNYARwLr1lZXlTLl6WCYWLOK3lreqJb+SnqXaL/07gv0b4ZAT/pbZ3k2CqdXTr5bvqIHfyhckAnzoX3wu0l731F5XwuntVeLDa0GB6g1638TEe7nja0oKk0UZE0P90+5FjlYc2Sqgf7GacrLIwdsiA1zAkrR1Ptd2uZlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIPQXsaf/SP718cKpLwy1xTHWu2XRxVgRWTteWA6iQI=;
 b=oQ9881fuE+F8w2NQ2DkUhD3yWbvhyqrPn/226GK6mxmaRa8uHgzxElv/UvwKxOB/IsOfm8W+I3jA5pZvydHLcJ3sNpuflUHeHohYk4apsACwAiTxIVHXA8PWd6DinUSM5Lovo6+ORwH3R9oHn4FPkZ7rypouN4euxWOTNXDbZmQ=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3136.namprd18.prod.outlook.com (10.255.236.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Wed, 7 Aug 2019 09:00:54 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::1b3:8b34:63fe:aad2]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::1b3:8b34:63fe:aad2%6]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 09:00:53 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     James Morse <james.morse@arm.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/24] EDAC, ghes: Remove pvt->detail_location string
Thread-Topic: [PATCH v2 03/24] EDAC, ghes: Remove pvt->detail_location string
Thread-Index: AQHVTP6eYTzHu+XjvEy3xRwejTLs+w==
Date:   Wed, 7 Aug 2019 09:00:53 +0000
Message-ID: <20190807090021.4w4a3f4wvyuszgj2@rric.localdomain>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-4-rrichter@marvell.com>
 <abbab8fd-d87e-d37d-b077-9f43474beaf8@arm.com>
In-Reply-To: <abbab8fd-d87e-d37d-b077-9f43474beaf8@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0004.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::14) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cf573db-a8f2-426f-2ff8-08d71b15c09d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3136;
x-ms-traffictypediagnostic: MN2PR18MB3136:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR18MB31363DE5980648E8A518F28AD9D40@MN2PR18MB3136.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(189003)(199004)(66066001)(305945005)(478600001)(8676002)(86362001)(7736002)(71200400001)(71190400001)(14454004)(966005)(6116002)(3846002)(486006)(53546011)(6486002)(6506007)(2906002)(5660300002)(66946007)(99286004)(66476007)(66556008)(64756008)(66446008)(54906003)(446003)(11346002)(386003)(316002)(102836004)(52116002)(76176011)(476003)(6436002)(6246003)(229853002)(9686003)(6306002)(1076003)(81156014)(81166006)(53936002)(4326008)(186003)(8936002)(14444005)(256004)(26005)(6916009)(68736007)(25786009)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3136;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: scsX8Ud5LSBSZo+i6aI85NkNKxjxSS+P0tQKyFVf6RpUNyUdwJThKcGn9ZZMre4jUsvGxngEV6uj1m/gR1GbjV8rwcIh+YwBgGa2OlgtlBdBrcnEsM5xwGVlPEmDZnaZ9cTT/768pC7thH6ASY75WVizSak+jlM5Ukdu4/A1uC78er1ssDwPKYhV77IHb3WHz2L4S/Q9lBpZ2jNCgoAqKozcUyBzjegcCbthBg3bQCbjJnR7Dr4oDAhsIVeVlz/ayBQ8KEtTP0zAYiAfP61nZSaDj2hfeJ/z5PCSzOWZZLMTdzAWsbJS4/cVrVDRqs50eKWfuTcRuj3NrMZbnrZU2ARn1jPOgdSh2X6yktFMClNI2M7xIqLtx90rJBLLZpP+fT5fB5DK5Prf7qepeL/CeRoBJOtD1qDdXmwddWnW11c=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C795A8FBE79FCD41A86F7B221F1DE4C3@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf573db-a8f2-426f-2ff8-08d71b15c09d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 09:00:53.8263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MrhWG3kiB32YqsCjTxt6jLkkfO13wpVKTaGNaiTqsTfN0C78Y8tMtnLzZ9wRtnieep7Sz5xcb76hVJZKwK2bYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3136
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-07_02:2019-08-05,2019-08-07 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 02.08.19 18:04:46, James Morse wrote:
> On 24/06/2019 16:08, Robert Richter wrote:
> > The detail_location[] string in struct ghes_edac_pvt is complete
> > useless and data is just copied around. Put everything into
> > e->other_detail from the beginning.

I am updating the description here to clarify it is only the internal
buffer that is removed. The other_detail[] string still provides a
decoded information of the apei error record.

> >=20
> > Signed-off-by: Robert Richter <rrichter@marvell.com>
> > ---
>=20
>=20
> > diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> > index d095d98d6a8d..049de73c3bad 100644
> > --- a/drivers/edac/ghes_edac.c
> > +++ b/drivers/edac/ghes_edac.c
> > @@ -21,8 +21,7 @@ struct ghes_edac_pvt {
> >  	struct mem_ctl_info *mci;
> > =20
> >  	/* Buffers for the error handling routine */
> > -	char detail_location[240];
> > -	char other_detail[160];
> > +	char other_detail[400];
> >  	char msg[80];
> >  };
> > =20
> > @@ -224,13 +223,14 @@ void ghes_edac_report_mem_error(int sev, struct c=
per_sec_mem_err *mem_err)
> >  	e->error_count =3D 1;
> >  	e->grain =3D 1;
> >  	strcpy(e->label, "unknown label");
> > -	e->msg =3D pvt->msg;
> > -	e->other_detail =3D pvt->other_detail;
> >  	e->top_layer =3D -1;
> >  	e->mid_layer =3D -1;
> >  	e->low_layer =3D -1;
> > -	*pvt->other_detail =3D '\0';
> > +	e->msg =3D pvt->msg;
> > +	e->other_detail =3D pvt->other_detail;
> > +
> >  	*pvt->msg =3D '\0';
> > +	*pvt->other_detail =3D '\0';

There are not code changes here, just a reordering for better
comparization with its counterpart in edac_mc.c. However, I am
removing this hunk here.

> > =20
> >  	switch (sev) {
> >  	case GHES_SEV_CORRECTED:
> > @@ -361,6 +361,8 @@ void ghes_edac_report_mem_error(int sev, struct cpe=
r_sec_mem_err *mem_err)
> > =20
> >  	/* All other fields are mapped on e->other_detail */
> >  	p =3D pvt->other_detail;
> > +	p +=3D snprintf(p, sizeof(pvt->other_detail),
> > +		"APEI location: %s ", e->location);
> >  	if (mem_err->validation_bits & CPER_MEM_VALID_ERROR_STATUS) {
> >  		u64 status =3D mem_err->error_status;
> > =20
> > @@ -443,12 +445,10 @@ void ghes_edac_report_mem_error(int sev, struct c=
per_sec_mem_err *mem_err)
> >  	grain_bits =3D fls_long(e->grain - 1);
> > =20
> >  	/* Generate the trace event */
> > -	snprintf(pvt->detail_location, sizeof(pvt->detail_location),
> > -		 "APEI location: %s %s", e->location, e->other_detail);
> >  	trace_mc_event(type, e->msg, e->label, e->error_count,
> >  		       mci->mc_idx, e->top_layer, e->mid_layer, e->low_layer,
> >  		       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
> > -		       grain_bits, e->syndrome, pvt->detail_location);
> > +		       grain_bits, e->syndrome, e->other_detail);
> > =20
> >  	edac_raw_mc_handle_error(type, mci, e);
> >  	spin_unlock_irqrestore(&ghes_lock, flags);
>=20
> After a game of spot-the-difference: you added a newline.
> Reviewed-by: James Morse <james.morse@arm.com>
>=20
> Previously here:
> https://lore.kernel.org/linux-edac/7017c91e-8923-c8d2-26ca-875328ab855a@a=
rm.com/
>=20
> Please pick up tags when posting a new version.

Let me know what you mean with this, I would like to ease review for
you. I tried to describe changes for v2 as detailed as possible.

Thank you.

-Robert
