Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95D96A3420
	for <lists+linux-edac@lfdr.de>; Fri, 30 Aug 2019 11:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfH3Jfi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Aug 2019 05:35:38 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:36676 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727455AbfH3Jfi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 30 Aug 2019 05:35:38 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7U9ZRLu025619;
        Fri, 30 Aug 2019 02:35:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=AVg2HvTFUoFwmq2R3d/7P0lC1lkT8lgOKc109E72Pho=;
 b=bqQ0yfMKX8rGKr2vhXZ6QueGYDdr6wl83RSi1Aws3X0DpK1GfD917mtngE2xphi8l4hN
 gu1eYhYLNslY6XJ8oym/KCYH2ve35nIP4yP/dgd4XbfXmlvw9itxc2prLMkAHxcNLZcU
 pB3XgewEGAzPDq29TWSZzLGAZcRypVDDCxOizNCYIqY4P//GzZVh90FkFNnFtnOiT4W5
 IqUnglRAD2Ytdq7tuyvVfsUkH5qIoflKpgeT8nisr5OqQnDLkbqQeFY+1xc+t3eYsQl5
 HSyTn87to8UqadNGqGOhaU0H3tQfa21RhN2rW0ZOvYyLw2wIs8bGAhppe24NHIKggHKc rQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2upmepjpme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 30 Aug 2019 02:35:27 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 30 Aug
 2019 02:35:25 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.58) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 30 Aug 2019 02:35:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyW84A7bwgCUQp4olFPfAiJcU/2gtJ9izD5DllhdEe01ChzeQYZq0GpEwWpey/4c5XjfwhlcRZHOFqcNYkTY5xhEF7O1KJY7PvKYHYbaysCRlAcVGTOJcH3WIYVIu0vi3UUwkeZLEj8h5i3Xon5C/RJIZX/K1iRXMOFe0U1tR5qdTBxFh6LobW0OFPr8Mh+YO8zWZggBnCsd8XdL53TCGPs988eFK66wVNldI9KkyaK1Or+C8//9PU51Zbovrne/g8foBjyCjZOrBeo79pbMWqvAqCzcs6rVzs/wuMapgXV8l6XwR4VfQDmg/mZtt+rRDHWxWwwjEwgyE15+pwswyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVg2HvTFUoFwmq2R3d/7P0lC1lkT8lgOKc109E72Pho=;
 b=bNff4/4+MwbT2xeO9eJWZahmbseGOZotBVpCwde56QbTIuwl0VvErba3ajAm5+wWPhx+SV/SRjdqprl7tCiZZJ7OJAT3zpgkprd+Q4qKD2wGaEH77RfQEJXJsnWaF82xvzyw/2rJairvCdbTYQ+P+KLKeqynspJ0F/8d6hPCzsLWIOuKI0DwNem5awSvDgR4V4egzIx12jIRLEjTIqHoc3LEhpwzDJaT3Lqonn7oYq2/aJQKyyV/NnGlVWXfyiGUUAR1xy0zsUBiTZnz0XC6Fx3Oed++HOeR204udtiSz8tD68SIaYktM/7aIxx4C5UaYM7hwCDmzt+aNc0BmUq24w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVg2HvTFUoFwmq2R3d/7P0lC1lkT8lgOKc109E72Pho=;
 b=qZD7kNWWVA5gDthtCphfq1Cyqu/VwHJKCM8cNunsibTXVk35++MFfDtkE80b25k9DYtHHHp6e86IxXFT5oiV8Vp8Fubv3mEM160gkSx1RCQsEQIAZ/Gun4/tTVjqQdDTC8Orfb6PzDTV8NAj85CSLNfwj9XrgSEaZP9DHo2WfmE=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3181.namprd18.prod.outlook.com (10.255.236.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Fri, 30 Aug 2019 09:35:23 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::8162:62e8:aeeb:ec7b%3]) with mapi id 15.20.2220.013; Fri, 30 Aug 2019
 09:35:23 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 13/24] EDAC, ghes: Add support for legacy API counters
Thread-Topic: [PATCH v2 13/24] EDAC, ghes: Add support for legacy API counters
Thread-Index: AQHVXxY/k/O/m3ZuPEe2DEuUofytfw==
Date:   Fri, 30 Aug 2019 09:35:23 +0000
Message-ID: <20190830093515.wrvoszz73aovl7tk@rric.localdomain>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-14-rrichter@marvell.com>
 <20190816095559.GL18980@zn.tnic>
In-Reply-To: <20190816095559.GL18980@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0089.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::33) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c016180-f99d-4dc2-1657-08d72d2d619c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3181;
x-ms-traffictypediagnostic: MN2PR18MB3181:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR18MB318188133ED7291CA0A8B64FD9BD0@MN2PR18MB3181.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39850400004)(346002)(366004)(376002)(199004)(189003)(54906003)(66556008)(14454004)(316002)(6512007)(66476007)(64756008)(66946007)(6306002)(6246003)(9686003)(6486002)(71200400001)(26005)(4326008)(6916009)(11346002)(486006)(6116002)(66446008)(446003)(6436002)(66066001)(102836004)(476003)(229853002)(53546011)(6506007)(386003)(81156014)(5660300002)(8676002)(81166006)(966005)(14444005)(8936002)(3846002)(71190400001)(25786009)(52116002)(1076003)(256004)(2906002)(305945005)(186003)(7736002)(53936002)(86362001)(478600001)(99286004)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3181;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Dft6qAze9V7GeQm6ftbAQ+9a4a8ppN539vnCuK4uwHo3oQdo9CBGy/twvQ0TQt5kjjofq88L1PM+GmS5w3kmMNT/TkZgiIMTsAPYV7i7RF1dwf1rjWt3UL05ptFxNu34XVW+VWmR6dbN5jbH32nHLSXDBhTCSteTtUZ5Psm1UxsR8If4j+ANIVh2n3wwnBtjS/WjucBwVFKBnew9BHoFe1GhIfm1WKMnq7HfC5S7p8DDqEqTuCAq6ik+gQ98DcVLarGIlcWn++Zag9+zZF5ElkrVJ1lQrKGFokmczRU4CbN+eoklqQpw1WdErj1mAiiPPnzQPtsyT77LhodrcFpxLejQ9PcWOIDje/NTILQU9QIpIc3/HfKXVpJhCuWEPP4ZBiY0Bpe1/GvEcUDJOf6vFMw8h1RVnkklMurKeFdO0dI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ED7B691DD4B8D347BDB6071EE202A956@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c016180-f99d-4dc2-1657-08d72d2d619c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 09:35:23.3850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5xr1vuAWeMOxI/Isq3Ayke7fbannyOx0t8AbzChyDuH+j4QYFQN1DjGVnaz4BN3lRlf4vvWU2RDPuGQWogqonA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3181
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-30_04:2019-08-29,2019-08-30 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 16.08.19 11:55:59, Borislav Petkov wrote:
> On Mon, Jun 24, 2019 at 03:09:22PM +0000, Robert Richter wrote:
> > The ghes driver is not able yet to count legacy API counters in sysfs,
> > e.g.:
> >=20
> >  /sys/devices/system/edac/mc/mc0/csrow2/ce_count
> >  /sys/devices/system/edac/mc/mc0/csrow2/ch0_ce_count
> >  /sys/devices/system/edac/mc/mc0/csrow2/ch1_ce_count
> >=20
> > Make counting csrows/channels generic so that the ghes driver can use
> > it too.
>=20
> What for?

Same was asked here:

 https://lore.kernel.org/patchwork/patch/1080277/

Actually it is a fix for the counters exposed by the legacy API for
the ghes driver. Counters are broken (set to zero). The ghes driver is
the only where errors are reported using edac_raw_mc_handle_error()
instead of edac_mc_handle_error().  The fix is to move the error
counting to edac_mc_handle_error() where the other counters are
incremented.

All distributions that I have checked enable the legacy API option
(CONFIG_EDAC_LEGACY_SYSFS=3Dy) and the interface cannot be disabled for
individual drivers. As long as the counters are exposed, their values
should be correct. See all options discussed in the thread from v1.

> ghes_edac enumerates the DIMMs from SMBIOS - it doesn't need chip
> selects and ranks. Those are used when you can't count the DIMMs
> properly...

Right, but that is true also for other drivers (actually all other
drivers since DIMMs are used now). It is to support older tools that
deal with */csrow*/ch* instead of */dimm* in sysfs.

-Robert
