Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C55644DDF
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2019 22:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfFMUyJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Jun 2019 16:54:09 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:40118 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725747AbfFMUyJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 13 Jun 2019 16:54:09 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DKmJLX026892;
        Thu, 13 Jun 2019 13:53:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=3+S8LE4Ao2Sr7pbFkjuJBIJrZXMTPGZ1VSFx7JD+2T8=;
 b=PneAh+QW+2EGxTMR8nOmdCKpsGRbnycc/KNdoa5sdsTd6wS9dDCTmHKiE5css9JwgHe2
 haDFBXwbgKFWW+bAZ+frJJ5P87XSb/d/+xCXBaSXQ1WMt8OfqE58Jvdzt/GhmWizeaUL
 XPm9VOc5ZKldPHJIDackAaybWegUcyEEziZmXYKkZGM0vdhYxeWlKKFA8GUIrf9MV/PS
 SOz/B4wYwq7MzWpwf3iDhszqVMlS7K90phHOoV8JN0yMmyyIzWU3gs3y9wfRnKdMwM8/
 Kt8Cj+q5bF/WL9Ecvc754h/Glxh6EVyqE9+pulpaFo2YqFWvDqS1w+Kcc2P1eajbN0wM FQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t3hvptw1t-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 13 Jun 2019 13:53:53 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 13 Jun
 2019 13:52:29 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.58) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 13 Jun 2019 13:52:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+S8LE4Ao2Sr7pbFkjuJBIJrZXMTPGZ1VSFx7JD+2T8=;
 b=LhFaEsGEsFJTbM2AZKafmO3mFW8Zq4DIc6dXqe08gfXDLgQe2+cg0x70bWACqmaErebhW4Z0guWcewmIhs6jtqUM81IYwosHIe7ZGtgNQyrS++DI5iDQcfsb/AH1URLvOEWN3oRspoJk6bL9lT+RQEdmhuoN7PFeaSNnIBns0WA=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2703.namprd18.prod.outlook.com (20.178.255.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 13 Jun 2019 20:52:27 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.1965.017; Thu, 13 Jun 2019
 20:52:27 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     James Morse <james.morse@arm.com>
CC:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/21] EDAC, ghes: Extract numa node information for each
 dimm
Thread-Topic: [PATCH 14/21] EDAC, ghes: Extract numa node information for each
 dimm
Thread-Index: AQHVIinoQDz9TIkOwEuZ4YTuyFfFBA==
Date:   Thu, 13 Jun 2019 20:52:27 +0000
Message-ID: <20190613205220.yeczoxxdhidnwcrf@rric.localdomain>
References: <20190529084344.28562-1-rrichter@marvell.com>
 <20190529084344.28562-15-rrichter@marvell.com>
 <42d1cb7f-de7a-31e8-eb89-8d0651a3501a@arm.com>
In-Reply-To: <42d1cb7f-de7a-31e8-eb89-8d0651a3501a@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0015.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::25) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.254.182.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40086ec5-30b1-4772-cd08-08d6f0410b25
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2703;
x-ms-traffictypediagnostic: MN2PR18MB2703:
x-microsoft-antispam-prvs: <MN2PR18MB2703421BE5D481C05A8F888BD9EF0@MN2PR18MB2703.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39850400004)(136003)(396003)(189003)(199004)(99286004)(102836004)(86362001)(68736007)(30864003)(25786009)(8936002)(81166006)(6246003)(4326008)(66066001)(76176011)(54906003)(6506007)(5660300002)(53936002)(386003)(53546011)(478600001)(8676002)(1076003)(256004)(52116002)(81156014)(14454004)(5024004)(14444005)(316002)(7736002)(229853002)(64756008)(66946007)(66446008)(66556008)(66476007)(73956011)(305945005)(6436002)(6486002)(6916009)(71190400001)(9686003)(6512007)(6116002)(26005)(3716004)(476003)(11346002)(71200400001)(186003)(486006)(446003)(2906002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2703;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Cw9MT7ACx9hmZsZtDbCN0wBenMXd6xG/Bzs67wnfQq18aZq6CgTfzRFVjKCFGaw64oaYgWlzB5Gsj3lJt18UYEIKkYZo0yxKpFymNGxOd5T2ulidWSs+MFSTLVmOFCQA5vUL6+5QHwNxgZFkhpcHs3iJgOEldgC5whrwBKHQOpocwv7ckISUhW7QVQmeZdqXRNpcvv80sUt5ukSTijSEnV3YMj3UTC1tmD4xcLopgvkCE6BkdLKNTv+KFEkg7f8uSEKGnLC4DZXAQIXLaGl1cx6GiT7Oa7PAAKIIw0rx7I6GuOifh521lSwH5xmk1E0a1GmcsUgkdnyi40hcon2jy2SoeQ/7NPJmyGDFHguIWgkjA1w/L+uOcvTo6u5c3d5EVmadWq9R8GGDpuT9KmzsR9IOu9Rl3OKdAU3DoBd1gpA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D44F177EC4E8734D8305E8BA6EB57877@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 40086ec5-30b1-4772-cd08-08d6f0410b25
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 20:52:27.5737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2703
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_12:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi James,

thank you for your review and response here. See my comments below.

On 29.05.19 18:51:00, James Morse wrote:
> On 29/05/2019 09:44, Robert Richter wrote:
> > In a later patch we want to have one mc device per node. This patch
> > extracts the numa node information for each dimm. This is done by
> > collecting the physical address ranges from the DMI table (Memory
> > Array Mapped Address - Type 19 of SMBIOS spec). The node information> f=
or a physical address is already know to a numa aware system (e.g. by
> > using the ACPI _PXM method or the ACPI SRAT table), so based on the PA
> > we can assign the node id to the dimms.
>=20
> I think you're letting the smbios information drive you here. We'd like t=
o do as much as
> possible without it, all its really good for is telling us the label on t=
he PCB.
>=20
> With this approach, you only get numa information by parsing more smbios,=
 which we have to
> try and validate, and fall back to some error path if it smells wrong. We=
 end up needing
> things like a 'fallback memory controller' in the case the firmware fault=
-time value is
> missing, or nuts.
>=20
> What bugs me is we already know the numa information from the address. We=
 could expose
> that without the smbios tables at all, and it would be useful to someone =
playing the
> dimm-bisect game. Not making it depend on smbios means there is a good ch=
ance it can
> become common with other edac drivers.

What a ghes driver will never have common with other edac drivers
is the knowledge of the memory hierarchy. Other drivers know the
underlying hardware and can determine the total number of dimms and
their location mapping indicated by a tuple (card/module, row/channel,
top_layer/mid_layer, etc.) using something like:

  index =3D top_layer * mid_layer_size + mid_layer;

The ghes driver cannot calculate a dimm index in that way since the
size of each layer is unknown. This only leaves you using the
dmi_handle from the error record to do the dimm mapping. I don't see
any other way here.

>=20
> I don't think we need to know the dimm->node mapping up front. When we ge=
t an error,
> pfn_to_nid() on the address tells us which node that memory is attached t=
o. This should be
> the only place nid information comes from, that way we don't need to chec=
k it. Trying to
> correlate it with smbios tables is much more code. If the CPER comes with=
 a DIMM handle,
> we know the DIMM too.

The dimm/node mapping is not the issue here and we could also use the
phys addr to select the node's memory controller. But we still need to
be able to somehow select the dimm the error belongs to. The ghes
driver cannot use the location tuple here to get the dimm index in the
mc's array.

> So all we really need is to know at setup time is how many numa-nodes the=
re are, and the
> maximum DIMM per node if we don't want phantom-dimms. Type-17 already has=
 a
> Physical-Memory-Array-Handle, which points at Type-19... but we don't nee=
d to read it,
> just count them and find the biggest.
>=20
> If the type-19 information is missing from smbios, or not linked up prope=
rly, or the
> values provided at fault-time don't overlap with the values in the table,=
 or there is no
> fault-time node information: you still get the numa-node information base=
d on the address.
>=20
> Using the minimum information should give us the least code, and the leas=
t exposure to
> misdescribed tables.

As said, we need the firmware here to locate the correct dimm an error
is reported for. I also would like to use the information of the
smbios at a minimum, but we rely on correct firmware tables here.
Assuming a broken fw and still having a correct driver does not work.
Why not just blame the firmware if something is wrong? I am sure it
will be corrected if edac does not properly work.

>=20
>=20
> > A fallback that disables numa is implemented in case the node
> > information is inconsistent.
>=20
> > diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> > index 50f4ee36b755..083452a48b42 100644
> > --- a/drivers/edac/ghes_edac.c
> > +++ b/drivers/edac/ghes_edac.c
> > @@ -67,14 +67,34 @@ struct memdev_dmi_entry {
> >  	u16 conf_mem_clk_speed;
> >  } __attribute__((__packed__));
> > =20
> > +/* Memory Array Mapped Address - Type 19 of SMBIOS spec */
> > +struct memarr_dmi_entry {
> > +	u8		type;
> > +	u8		length;
> > +	u16		handle;
> > +	u32		start;
> > +	u32		end;
> > +	u16		phys_mem_array_handle;
> > +	u8		partition_width;
> > +	u64		ext_start;
> > +	u64		ext_end;
> > +} __attribute__((__packed__));
>=20
> Any chance we could collect the structures from the smbios spec in a head=
er file somewhere?

I could create a new ghes_edac.h file, but the only user is
ghes_edac.c? Does not make sense to me.

>=20
> I'd prefer not to read this thing at all if we can help it.

I don't see how else we identify the dimm other than the phys addr
range and the smbios handle?

>=20
> >  struct ghes_dimm_info {
> >  	struct dimm_info dimm_info;
> >  	int		idx;
> > +	int		numa_node;
>=20
> (I thought nid was the preferred term)

struct device uses numa_node here, so I chose this one.

>=20
>=20
> > +	phys_addr_t	start;
> > +	phys_addr_t	end;
>=20
> I think start and end are deceptive as they overlap with other DIMMs on s=
ystems with
> interleaving memory controllers. I'd prefer not to keep these values arou=
nd.

The (start) address is only used for dimm/node mapping.

>=20
>=20
> > +	u16		phys_handle;
> >  };
> > =20
> >  struct ghes_mem_info {
> > -	int num_dimm;
> > +	int		num_dimm;
> >  	struct ghes_dimm_info *dimms;
> > +	int		num_nodes;
>=20
> > +	int		num_per_node[MAX_NUMNODES];
>=20
> Number of what?

dimms_per_node, will change.

>=20
>=20
> > +	bool		enable_numa;
>=20
> This is used locally in mem_info_setup(), but its not read from here by a=
ny of the later
> patches in the series. Is it needed?

No, not really, will remove it.

>=20
> I don't like the idea that this is behaviour that is turned on/off. Its a=
 property of the
> system. I think it would be better if CONFIG_NUMA causes you to get multi=
ple
> memory-controllers created, but if its not actually a NUMA machine there =
would only be
> one. This lets us test that code on not-really-numa systems.

There is only one node if CONFIG_NUMA is disabled and only one mc is
created.

We disable per-node memory controllers only if the node id cannot be
determined properly for some reason.

>=20
>=20
> >  };
> > =20
> >  struct ghes_mem_info mem_info;
> > @@ -97,10 +117,50 @@ static void ghes_dimm_info_init(void)
> > =20
> >  	for_each_dimm(dimm) {
> >  		dimm->idx	=3D idx;
> > +		dimm->numa_node	=3D NUMA_NO_NODE;
> >  		idx++;
> >  	}
> >  }
> > =20
> > +static void ghes_edac_set_nid(const struct dmi_header *dh, void *arg)
> > +{
> > +	struct memarr_dmi_entry *entry =3D (struct memarr_dmi_entry *)dh;
> > +	struct ghes_dimm_info *dimm;
> > +	phys_addr_t start, end;
> > +	int nid;
> > +
> > +	if (dh->type !=3D DMI_ENTRY_MEM_ARRAY_MAPPED_ADDR)
> > +		return;
>=20
> > +	/* only support SMBIOS 2.7+ */
> > +	if (entry->length < sizeof(*entry))
> > +		return;
>=20
> Lovely. I still hope we can get away without parsing this table.
>=20
>=20
> > +	if (entry->start =3D=3D 0xffffffff)
> > +		start =3D entry->ext_start;
> > +	else
> > +		start =3D entry->start;
> > +	if (entry->end =3D=3D 0xffffffff)
> > +		end =3D entry->ext_end;
> > +	else
> > +		end =3D entry->end;
>=20
>=20
> > +	if (!pfn_valid(PHYS_PFN(start)))
> > +		return;
>=20
> Eh? Just because there is no struct page doesn't mean firmware won't repo=
rt errors for it.
> This is going to bite on arm64 if the 'start' page happens to have been r=
eserved by
> firmware, and thus doesn't have a struct page. Bottom-up allocation doesn=
't sound unlikely.

It looks like the memblock areas have a finer granularity than the
memory ranges in the DMI and SRAT table. DMI and SRAT have the same
areas on the system that I have used for testing.=20

SRAT is the area used to setup pfns. If that maps with the dmi table
and the memblocks are within that range, I don't see an issue.

The fallback would be the node is not detectable and per-node mc
allocation is disabled.

----
# dmidecode | grep -A 5 'Memory Array Mapped Address'
Memory Array Mapped Address
       Starting Address: 0x0000000080000000k
       Ending Address: 0x00000000FEFFFFFFk
       Range Size: 2032 MB
       Physical Array Handle: 0x0037
       Partition Width: 1
--
Memory Array Mapped Address
       Starting Address: 0x0000000880000000k
       Ending Address: 0x0000000FFFFFFFFFk
       Range Size: 30 GB
       Physical Array Handle: 0x0037
       Partition Width: 1
--
Memory Array Mapped Address
       Starting Address: 0x0000008800000000k
       Ending Address: 0x0000009FFCFFFFFFk
       Range Size: 98256 MB
       Physical Array Handle: 0x0037
       Partition Width: 1
--
Memory Array Mapped Address
       Starting Address: 0x0000009FFD000000k
       Ending Address: 0x000000BFFCFFFFFFk
       Range Size: 128 GB
       Physical Array Handle: 0x004E
       Partition Width: 1
# dmesg | grep SRAT:.*mem
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000-0xfeffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x880000000-0xfffffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x8800000000-0x9ffcffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x9ffd000000-0xbffcffffff]
# dmesg
[...]
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000802f0000-0x000000008030ffff]
[    0.000000]   node   0: [mem 0x0000000080310000-0x00000000bfffffff]
[    0.000000]   node   0: [mem 0x00000000c0000000-0x00000000c0ccffff]
[    0.000000]   node   0: [mem 0x00000000c0cd0000-0x00000000f95effff]
[    0.000000]   node   0: [mem 0x00000000f95f0000-0x00000000f961ffff]
[    0.000000]   node   0: [mem 0x00000000f9620000-0x00000000fac3ffff]
[    0.000000]   node   0: [mem 0x00000000fac40000-0x00000000faddffff]
[    0.000000]   node   0: [mem 0x00000000fade0000-0x00000000fc8dffff]
[    0.000000]   node   0: [mem 0x00000000fc8e0000-0x00000000fc8effff]
[    0.000000]   node   0: [mem 0x00000000fc8f0000-0x00000000fcaaffff]
[    0.000000]   node   0: [mem 0x00000000fcab0000-0x00000000fcacffff]
[    0.000000]   node   0: [mem 0x00000000fcad0000-0x00000000fcb4ffff]
[    0.000000]   node   0: [mem 0x00000000fcb50000-0x00000000fd1fffff]
[    0.000000]   node   0: [mem 0x00000000fd200000-0x00000000fecfffff]
[    0.000000]   node   0: [mem 0x00000000fed00000-0x00000000fed2ffff]
[    0.000000]   node   0: [mem 0x00000000fed30000-0x00000000fed3ffff]
[    0.000000]   node   0: [mem 0x00000000fed40000-0x00000000fedeffff]
[    0.000000]   node   0: [mem 0x00000000fedf0000-0x00000000feffffff]
[    0.000000]   node   0: [mem 0x0000000880000000-0x0000000fffffffff]
[    0.000000]   node   0: [mem 0x0000008800000000-0x0000009ffcffffff]
[    0.000000]   node   1: [mem 0x0000009ffd000000-0x000000bffcffffff]
[...]
----

>=20
>=20
> > +	nid =3D pfn_to_nid(PHYS_PFN(start));
>=20
> ... Ugh, because pfn_to_nid() goes via struct page.
>=20
> You can make this robust by scanning start->end looking for a pfn_valid()=
 you can pull the
> nid out of. (no, I don't think its a good idea either!)
>=20
> I'd like to see if we can get rid of the 'via address' part of this.
>=20
>=20
> > +	if (nid < 0 || nid >=3D MAX_NUMNODES || !node_possible(nid))
> > +		nid =3D NUMA_NO_NODE;
>=20
> Can this happen? Does this indicate the firmware tables are wrong, or mm =
is about derail?

It's a range check, pfn_to_nid() is implementation defined, just make
sure things are as expected.

>=20
>=20
> > +	for_each_dimm(dimm) {
> > +		if (entry->phys_mem_array_handle =3D=3D dimm->phys_handle) {
> > +			dimm->numa_node	=3D nid;
> > +			dimm->start	=3D start;
> > +			dimm->end	=3D end;
> > +		}
> > +	}
> > +}
> > +
> >  static int get_dimm_smbios_index(u16 handle)
> >  {
> >  	struct mem_ctl_info *mci =3D ghes_pvt->mci;
> > @@ -213,8 +273,25 @@ static void ghes_edac_dmidecode(const struct dmi_h=
eader *dh, void *arg)
> >  	}
> >  }
> > =20
> > +static void mem_info_disable_numa(void)
> > +{
> > +	struct ghes_dimm_info *dimm;
> > +
> > +	for_each_dimm(dimm) {
> > +		if (dimm->numa_node !=3D NUMA_NO_NODE)
> > +			mem_info.num_per_node[dimm->numa_node] =3D 0;
>=20
> > +		dimm->numa_node =3D 0;
>=20
> NUMA_NO_NODE?

No, this is the index to the one and only mem controller that we have
with numa disabled for edac.

>=20
> > +	}
> > +
> > +	mem_info.num_per_node[0] =3D mem_info.num_dimm;
> > +	mem_info.num_nodes =3D 1;
> > +	mem_info.enable_numa =3D false;
> > +}
> > +
> >  static int mem_info_setup(void)
> >  {
> > +	struct ghes_dimm_info *dimm;
> > +	bool enable_numa =3D true;
> >  	int idx =3D 0;
> > =20
> >  	memset(&mem_info, 0, sizeof(mem_info));
> > @@ -231,6 +308,29 @@ static int mem_info_setup(void)
> > =20
> >  	ghes_dimm_info_init();
> >  	dmi_walk(ghes_edac_dmidecode, &idx);
> > +	dmi_walk(ghes_edac_set_nid, NULL);
> > +
> > +	for_each_dimm(dimm) {
> > +		if (dimm->numa_node =3D=3D NUMA_NO_NODE) {
> > +			enable_numa =3D false;
> > +		} else {
>=20
> > +			if (!mem_info.num_per_node[dimm->numa_node])
> > +				mem_info.num_nodes++;
>=20
> This is to try and hide empty nodes?

This is consumed nowhere and can be removed.

>=20
>=20
> > +			mem_info.num_per_node[dimm->numa_node]++;
>=20
> Could you do these two in your previous for_each_dimm() walk?

This must be called after the ghes_edac_set_nid walker.

>=20
>=20
> > +		}
> > +
> > +		edac_dbg(1, "DIMM%i: Found mem range [%pa-%pa] on node %d\n",
> > +			dimm->idx, &dimm->start, &dimm->end, dimm->numa_node);
> > +	}
>=20
>=20
> > +	mem_info.enable_numa =3D enable_numa;
> > +	if (enable_numa)
> > +		return 0;
> > +
> > +	/* something went wrong, disable numa */
> > +	if (num_possible_nodes() > 1)
> > +		pr_warn("Can't get numa info, disabling numa\n");
> > +	mem_info_disable_numa();
>=20
> I'd like to find a way of doing this where we don't need this sort of thi=
ng!

I fear that might not be possible and you can't have one without the
other. You need the tables to setup the dimms and you need the smbios
handle to map the error to the dimm.

-Robert

>=20
>=20
> Thanks,
>=20
> James
