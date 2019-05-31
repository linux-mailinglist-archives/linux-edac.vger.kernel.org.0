Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 369EE30F1F
	for <lists+linux-edac@lfdr.de>; Fri, 31 May 2019 15:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfEaNmO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 31 May 2019 09:42:14 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:58192 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726415AbfEaNmO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 31 May 2019 09:42:14 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4VDZvJZ024107;
        Fri, 31 May 2019 06:41:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=JGlzfLtenNcanSLxvk+pGas02uo8K5U6TXd9lQ8R3GQ=;
 b=EHK1CHlnylG+R7HP+PpJsoitmvN0rUqZ6lT30PxnLlHpS6IErWlVWEhyfZqEbeD6p9sC
 ShnnPzjqGXUKYFd6bs8n8YKpV3tACfq9UPQio+uRY4tJCIbrzSs1/o97uQUaX9XtczDc
 woPvzV0V/MnDVmZfjXpBUWTffmOxGlggqZKLar1QG2YgbhMNmHec+115KlxtiQcFPvRG
 fHaQMTuP1w+AslaCPhhEXYrGeXS7qFK9QE14Jf/ONdp9zN2F09Hz64YWNTiybRC63JxO
 vxRMcH0ekk8iWZ5qPVpD2kLHY10xlZVufGsF89kD4cRnKyh75j8gfLdXzGFyUJCouyUF AA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2sttf12e8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 31 May 2019 06:41:56 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 31 May
 2019 06:41:55 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.50) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 31 May 2019 06:41:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGlzfLtenNcanSLxvk+pGas02uo8K5U6TXd9lQ8R3GQ=;
 b=mJXSam33KGCAcY27aE2a62x3tws+xW2vTqYmBSYPGlU7kKWNBEvdOCc+qq/OpRW7B+5twS/Lsd7f60d5OvUMYbmLadfInF6lXI7xa/L1Q8sy06FkCrfAHlUKmhkLCpx6NPqIMHYuQM+s1ia5r4DeLvTME5vMGh3voYdV1sBV6RQ=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3103.namprd18.prod.outlook.com (10.255.86.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Fri, 31 May 2019 13:41:50 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a%4]) with mapi id 15.20.1922.024; Fri, 31 May 2019
 13:41:50 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     James Morse <james.morse@arm.com>
CC:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/21] EDAC, ghes: Rework memory hierarchy detection
Thread-Topic: [PATCH 13/21] EDAC, ghes: Rework memory hierarchy detection
Thread-Index: AQHVF7aZeP/S8MgwF0qqiyyDsanUOQ==
Date:   Fri, 31 May 2019 13:41:50 +0000
Message-ID: <20190531134143.fuxl2uzwpam255bs@rric.localdomain>
References: <20190529084344.28562-1-rrichter@marvell.com>
 <20190529084344.28562-14-rrichter@marvell.com>
 <068e31b4-43e8-c1ab-194e-f2b41c1534f9@arm.com>
In-Reply-To: <068e31b4-43e8-c1ab-194e-f2b41c1534f9@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0095.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::36) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.11.73.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60b24a80-90f0-46b6-c9dd-08d6e5cdbbe9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR18MB3103;
x-ms-traffictypediagnostic: MN2PR18MB3103:
x-microsoft-antispam-prvs: <MN2PR18MB31035AD02D8310324CD5C95FD9190@MN2PR18MB3103.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(136003)(346002)(199004)(189003)(71190400001)(6512007)(256004)(305945005)(11346002)(14444005)(446003)(73956011)(66066001)(66946007)(7736002)(66556008)(5660300002)(478600001)(2906002)(64756008)(66446008)(66476007)(9686003)(6246003)(53936002)(186003)(68736007)(14454004)(26005)(86362001)(99286004)(25786009)(3846002)(6116002)(71200400001)(8676002)(54906003)(6916009)(316002)(52116002)(81156014)(386003)(6506007)(486006)(4326008)(102836004)(53546011)(81166006)(476003)(6436002)(6486002)(229853002)(76176011)(1076003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3103;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FbuMd8wTzUHHz4dQRAsACkhrWhsY5X2/u8znLlhz81LbppGPIVHQQknWcAlNmj3CSne6/Tte9MHO7+YDtJLIxZIo7dyZuq5VfWmVOeDAUCU0ex5x6DQ+oFabOaIRPApnVXbEJdfbPLVvy61NRkpHVRYBqEcphF28DwTdA83Rn3y4aEGN0NwHw4h/L55C+qq/dy1IrIhuxv5BOQg8PL2DXD1FBs1nlWPyFTz1m3toojymeFMjFdPUvUZPIy8ACUycbvZcZICGitCkyKXnj2ug/xrnLYmFdJKpbQrcONrU+9CsJVNdF5jELrezBBohzi+EcRMVkfnUvJsWop+69TkvY/r/6hLs0yxbIoWyocXi/FjA7P0yru49DecU3mC33Kp2Zw/pML4xVxl+lFP/n98/BU55Vy5nnUNRAAAdsQi+3Bs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2D9EBAC592506B4A9CE6AD71308CEBC4@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b24a80-90f0-46b6-c9dd-08d6e5cdbbe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 13:41:50.7484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3103
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-31_08:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi James,

thanks for your review. See below.

On 29.05.19 16:06:55, James Morse wrote:
> Hi Robert,
>=20
> On 29/05/2019 09:44, Robert Richter wrote:
> > In a later patch we want add more information about the memory
> > hierarchy (NUMA topology, DIMM label information). Rework memory
> > hierarchy detection to make the code extendable for this.
> >=20
> > The general approach is roughly like:
> >=20
> > 	mem_info_setup();
> > 	for_each_node(nid) {
> > 		mci =3D edac_mc_alloc(nid);
> > 		mci_add_dimm_info(mci);
> > 		edac_mc_add_mc(mci);
> > 	};
> >=20
> > This patch introduces mem_info_setup() and mci_add_dimm_info().
> >=20
> > All data of the memory hierarchy is collected in a local struct
> > ghes_mem_info.
> >=20
> > Note: Per (NUMA) node registration will be implemented in a later
> > patch.
>=20
>=20
> > diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> > index ea4d53043199..50f4ee36b755 100644
> > --- a/drivers/edac/ghes_edac.c
> > +++ b/drivers/edac/ghes_edac.c
> > @@ -67,17 +67,38 @@ struct memdev_dmi_entry {
> >  	u16 conf_mem_clk_speed;
> >  } __attribute__((__packed__));
> > =20
> > -struct ghes_edac_dimm_fill {
> > -	struct mem_ctl_info *mci;
> > -	unsigned count;
>=20
> > +struct ghes_dimm_info {
> > +	struct dimm_info dimm_info;
> > +	int		idx;
> > +};
>=20
> > +struct ghes_mem_info {
> > +	int num_dimm;
> > +	struct ghes_dimm_info *dimms;
> >  };
> > =20
> > +struct ghes_mem_info mem_info;
>=20
> static?

Yes, this can be made static.

Will update the code.

>=20
>=20
> > @@ -94,18 +115,17 @@ static int get_dimm_smbios_index(u16 handle)
> > =20
> >  static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg=
)
> >  {
> > -	struct ghes_edac_dimm_fill *dimm_fill =3D arg;
> > -	struct mem_ctl_info *mci =3D dimm_fill->mci;
> > -
> >  	if (dh->type =3D=3D DMI_ENTRY_MEM_DEVICE) {
> > +		int *idx =3D arg;
> >  		struct memdev_dmi_entry *entry =3D (struct memdev_dmi_entry *)dh;
> > -		struct dimm_info *dimm =3D edac_get_dimm(mci, dimm_fill->count,
> > -						       0, 0);
> > +		struct ghes_dimm_info *mi =3D &mem_info.dimms[*idx];
> > +		struct dimm_info *dimm =3D &mi->dimm_info;
> >  		u16 rdr_mask =3D BIT(7) | BIT(13);
>=20
>=20
> > +		mi->phys_handle =3D entry->phys_mem_array_handle;
>=20
> Where did this come from, and what is it for?
>=20
> ...
>=20
> Should this be in a later patch? (did you bisect build this?)

The change should be part of the next patch:

 EDAC, ghes: Extract numa node information for each dimm

It breaks the build here.

Will update the code.

>=20
>=20
> >  		if (entry->size =3D=3D 0xffff) {
> > -			pr_info("Can't get DIMM%i size\n",
> > -				dimm_fill->count);
> > +			pr_info("Can't get DIMM%i size\n", mi->idx);
> >  			dimm->nr_pages =3D MiB_TO_PAGES(32);/* Unknown */
> >  		} else if (entry->size =3D=3D 0x7fff) {
> >  			dimm->nr_pages =3D MiB_TO_PAGES(entry->extended_size);
>=20
>=20
> > +static int mem_info_setup(void)
> > +{
> > +	int idx =3D 0;
> > +
> > +	memset(&mem_info, 0, sizeof(mem_info));
>=20
> Is this necessary? Isn't mem_info in the BSS, it will zero'd already.

For clarity I don't want to just *assume* the data is zero, instead I
want to *ensure* it is because mem_info could be initialized and used
more than one time. I think this is of not much cost but improves code
maintainability.

This structure is used locally here for all driver instances (there is
only one istance allowed but there could be a 2nd initialization
attempt after a first instance has been shut down). For consistent
data we rely on that struct being zero from the beginning. Without
that it would be zero only after a boot. I put this in here to
emphasize the assumption the struct must be zero, even if the mem is
zero when initializing it the first time, and it is very unlikely, the
driver will be initialized a 2nd time.

>=20
>=20
> > +	/* Get the number of DIMMs */
> > +	dmi_walk(ghes_edac_count_dimms, NULL);
> > +	if (!mem_info.num_dimm)
> > +		return -EINVAL;
>=20
> > +	mem_info.dimms =3D kcalloc(mem_info.num_dimm,
> > +				sizeof(*mem_info.dimms), GFP_KERNEL);
> > +	if (!mem_info.dimms)
> > +		return -ENOMEM;
>=20
> > +	ghes_dimm_info_init();
>=20
> Could you move the kcalloc() into ghes_dimm_info_init()? This would save =
you having a
> unnecessarily-different version in mem_info_setup_fake().

Sure, see below.

>=20
>=20
> > +	dmi_walk(ghes_edac_dmidecode, &idx);
> > +
> > +	return 0;
> > +}
>=20
> > +static int mem_info_setup_fake(void)
> > +{
> > +	struct ghes_dimm_info *ghes_dimm;
> > +	struct dimm_info *dimm;
> > +
> > +	memset(&mem_info, 0, sizeof(mem_info));
>=20
> Is this necessary? Its only been touched by mem_info_setup(), and you get=
 in here because
> mem_info.num_dimm =3D=3D 0...

In this particular case everything is still zero. But the above
applies here too.

>=20
>=20
> > +	ghes_dimm =3D kzalloc(sizeof(*mem_info.dimms), GFP_KERNEL);
> > +	if (!ghes_dimm)
> > +		return -ENOMEM;
>=20
> This is common with mem_info_setup(). If ghes_dimm_info_init() read mem_i=
nfo.num_dimm and
> did the rest, you'd avoid some duplication here.

Looks good to me and makes the setup code more straight.

Will update the code.

>=20
>=20
> > +	mem_info.num_dimm =3D 1;
> > +	mem_info.dimms =3D ghes_dimm;
> > +
> > +	ghes_dimm_info_init();
> > +
> > +	dimm =3D &ghes_dimm->dimm_info;
> > +	dimm->nr_pages =3D 1;
> > +	dimm->grain =3D 128;
> > +	dimm->mtype =3D MEM_UNKNOWN;
> > +	dimm->dtype =3D DEV_UNKNOWN;
> > +	dimm->edac_mode =3D EDAC_SECDED;
> > +
> > +	return 0;
> > +}
>=20
>=20
> > +static void mci_add_dimm_info(struct mem_ctl_info *mci)
>=20
> (From the name I expected this to be in edac_mc.c)

I will rename it to mem_info_prepare_mci() which is more in the line
with the other mem_info_*() functions.

Will update the code.

>=20
>=20
> > +{
> > +	struct dimm_info *mci_dimm, *dmi_dimm;
> > +	struct ghes_dimm_info *dimm;
> > +	int index =3D 0;
> > +
> > +	for_each_dimm(dimm) {
> > +		dmi_dimm =3D &dimm->dimm_info;
> > +		mci_dimm =3D edac_get_dimm_by_index(mci, index);
> > +
> > +		index++;
> > +		if (index > mci->tot_dimms)
> > +			break;
> > +
> > +		mci_dimm->nr_pages	=3D dmi_dimm->nr_pages;
> > +		mci_dimm->mtype		=3D dmi_dimm->mtype;
> > +		mci_dimm->edac_mode	=3D dmi_dimm->edac_mode;
> > +		mci_dimm->dtype		=3D dmi_dimm->dtype;
> > +		mci_dimm->grain		=3D dmi_dimm->grain;
> > +		mci_dimm->smbios_handle =3D dmi_dimm->smbios_handle;
> >  	}
>=20
> This isn't fun. I guess 'numa' is the reason for generating a shadow copy=
 of all this, and
> then having to copy it into edac. But surely that isn't a problem unique =
to ghes_edac.c?

We need to collect all the memory hierarchy and dimm info before we
can call edac_mc_alloc(). Thus, the data is almost duplicate but I
don't see a way to avoid this.

I was thinking of splitting struct dimm_info in 2 parts with another
struct in it to copy over the data as struct in one shot without
overwriting parts of the data setup by edac_mc_alloc().

I also see this isn't ideal but don't see an alternative at the
moment.

>=20
> Can't you add the nid, and any other properties to struct dimm_info? It a=
lready has
> smbios_handle, which is hardly useful to other drivers!

I will move smbios_handle back to struct ghes_dimm_info.

Will update the code.

>=20
>=20
> > +	if (index !=3D mci->tot_dimms)
> > +		pr_warn("Unexpected number of DIMMs: %d (exp. %d)\n",
> > +			index, mci->tot_dimms);
> >  }
>=20
>=20
> > @@ -472,22 +566,24 @@ int ghes_edac_register(struct ghes *ghes, struct =
device *dev)
>=20
> >  	mci =3D edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(struct gh=
es_edac_pvt));
> >  	if (!mci) {
> > -		pr_info("Can't allocate memory for EDAC data\n");
> > +		pr_err("Can't allocate memory for EDAC data\n");
>=20
> Leftover debug?

No, this is a real error causing the init to fail. Thus, adjusting log
level here. I changed it in this patch to align the log levels with
the other new introduced error message in this patch.

>=20
> 		kfree(mem_info.dimms); ?
>=20
> >  		return -ENOMEM;
> >  	}
> > =20
> > @@ -513,26 +609,14 @@ int ghes_edac_register(struct ghes *ghes, struct =
device *dev)
>=20
> > -	if (!fake) {
> > -		dimm_fill.count =3D 0;
> > -		dimm_fill.mci =3D mci;
> > -		dmi_walk(ghes_edac_dmidecode, &dimm_fill);
> > -	} else {
> > -		struct dimm_info *dimm =3D edac_get_dimm(mci, 0, 0, 0);
> > -
> > -		dimm->nr_pages =3D 1;
> > -		dimm->grain =3D 128;
> > -		dimm->mtype =3D MEM_UNKNOWN;
> > -		dimm->dtype =3D DEV_UNKNOWN;
> > -		dimm->edac_mode =3D EDAC_SECDED;
> > -	}
> > +	mci_add_dimm_info(mci);
> > =20
> >  	rc =3D edac_mc_add_mc(mci);
> >  	if (rc < 0) {
> > -		pr_info("Can't register at EDAC core\n");
> > +		pr_err("Can't register at EDAC core\n");
>=20
> Leftover debug?

Same here.

>=20
> >  		edac_mc_free(mci);
>=20
> 		kfree(mem_info.dimms); ?
>=20
> >  		return -ENODEV;
> >  	}
>=20
>=20
> Thanks!

Thank you for review.

-Robert

>=20
> James
