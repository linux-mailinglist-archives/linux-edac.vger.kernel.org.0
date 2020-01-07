Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C26DE132701
	for <lists+linux-edac@lfdr.de>; Tue,  7 Jan 2020 14:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgAGNEn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 7 Jan 2020 08:04:43 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:13746 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726937AbgAGNEn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 7 Jan 2020 08:04:43 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 007D1lMk007548;
        Tue, 7 Jan 2020 05:04:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=PapBjB2D4BevT6jTzx/lRTZwzdDkc9lhSKQRfENM4fY=;
 b=NmtZtWAe2ukFY0siFf3ElUWMJf+dKbWcmxjFasGLf+tDhevIHxcGFbCYjumoIZ0H8/Qa
 KCJLjYigpomfRLZe5Be0aOSQ4EgOeeXrB0yISpOWtiwoi2NcPVmjwS8DDnKykrLXO1Ov
 zlrsSMqdnxlg/tAHcN6PAzDaAEfaMVIAk7kzGZQ8jDtjdjxom3udn+keJDr7WqkGfvkf
 ONftducsA5zxue5hDn6UaLWxDs9au9QrZbwy0fCmDTW6uLvRXGWl2pdCmYv8lP4wSPNY
 TSpx0CyBpu6FIihhsSUdw9cmok34/WyvarYjXj2kb6YFZ0JvMlN/NmAITLctqXlgtR0Q Xw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2xarxvaegr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 07 Jan 2020 05:04:32 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 7 Jan
 2020 05:04:31 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 7 Jan 2020 05:04:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDmkDKixyB7kS+Sld7urHG/s1cqmDZjgvzyTiDLa+hhZqdzbODZlAN3ZZGNPkAD93CFEhJ/nHB0Kdbh7if+Oc9k1mGAoKxu3OC5Qi15H02TgvYvnponka4zEKikSajY2dAlb2yM7fVU+z7ms/qPzmehXOSNX9FLgvhBB/3c+tk2fcEdwqqmMxyPqLPQWgIi2lhuEXdX2BUq8g89LQOnjXAxsxLnTkSqb/5uO5vhYxazoBRe4pbuzhERDXfghEme7jOJ+nF/pG3dRaNj3MVopw4Em8FaM5ChQiMQxWRilN3wd9qK7F+8+ZnEc4zytvsmBL1Nn4+WJ2TGhS8MVjxa/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PapBjB2D4BevT6jTzx/lRTZwzdDkc9lhSKQRfENM4fY=;
 b=Rsq/n/iicCwOYQPd3XuFoPApITDmVv7Xa3PvtI/TwX5hkQ4NQ7/v/0qCKBTxP7e+ybD6B13+JGGjq+kBFgNIc+QhrlvUTdTYNZ9wLg+kmKfLv3Kum39EDLZhNDx+5cyGMbvkPIMhTzGe7lOCRJ8qyQGsGHV14HH5u1ceEzoCzKlxSNoqkMSr4qq9+takYtgw9mZvuLt/CWNobqPtf5t2CrMYXfw0r3KgPKmJ9Mss/OaZwTmzv/5jkHxqKjYqTxOd3V7jXFoMem9BVoMKJ51iNngY47tyzm5ydn/odxePb0JVh1msM57gmPbbc4PuPYfQr6ZPVms8Pdv6OU2TIDwVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PapBjB2D4BevT6jTzx/lRTZwzdDkc9lhSKQRfENM4fY=;
 b=ZiR3aOcq/F2krSEk/tJ41GoR0X2yeWJga7HB+kxv2bvyqjcN1Sf/Co3diNsMm0mDR1etccTKIdZQ8HxAK1/BL8x9j0az+0AUzG74V/6+NGb3I1604Po5NqJ6hygq0xZdl3rMGPFSuzmHG1lwbOYkXVPYRrmOGU1XwYOsUKWtIa8=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3120.namprd18.prod.outlook.com (10.255.86.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Tue, 7 Jan 2020 13:04:30 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2602.016; Tue, 7 Jan 2020
 13:04:29 +0000
Received: from rric.localdomain (31.208.96.227) by HE1PR06CA0139.eurprd06.prod.outlook.com (2603:10a6:7:16::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11 via Frontend Transport; Tue, 7 Jan 2020 13:04:28 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Bhaskar Upadhaya <bhaskar.upadhaya.linux@gmail.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Bhaskar Upadhaya <bupadhaya@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Ganapatrao Prabhakerrao Kulkarni" <gkulkarni@marvell.com>
Subject: Re: [RFC PATCH] apei/ghes: fix ghes_poll_func by registering in
 non-deferrable mode
Thread-Topic: [RFC PATCH] apei/ghes: fix ghes_poll_func by registering in
 non-deferrable mode
Thread-Index: AQHVxVr/VOkX2frOhEK2VGBkBP552Q==
Date:   Tue, 7 Jan 2020 13:04:29 +0000
Message-ID: <20200107130421.6w67frcsllkblie2@rric.localdomain>
References: <1576652618-27017-1-git-send-email-bupadhaya@marvell.com>
 <20200102180130.GG8345@zn.tnic>
 <CAEYJA6oXTxTmJEji5_Hup2oB+GrgGnmSTiS-nNuzbNzGJ9VESA@mail.gmail.com>
 <20200106130949.GD12238@zn.tnic>
 <CAEYJA6rPiBYnM4rT5WJnvTSrk6GBHeLYxK5OF5oxmeVxVepGGQ@mail.gmail.com>
In-Reply-To: <CAEYJA6rPiBYnM4rT5WJnvTSrk6GBHeLYxK5OF5oxmeVxVepGGQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0139.eurprd06.prod.outlook.com
 (2603:10a6:7:16::26) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7f32b6b-ceb8-4333-f319-08d793722194
x-ms-traffictypediagnostic: MN2PR18MB3120:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3120A23D95A26B8E6F2159D2D93F0@MN2PR18MB3120.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(186003)(16526019)(26005)(316002)(5660300002)(478600001)(6506007)(53546011)(52116002)(7696005)(54906003)(1076003)(64756008)(66556008)(66476007)(956004)(2906002)(66946007)(66446008)(8936002)(71200400001)(81156014)(6916009)(81166006)(86362001)(8676002)(4326008)(107886003)(55016002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3120;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BgWmCJB7QuOa0CjnTHvdZFfUgzJz5HZDiSmo7LANKo0laKmOraG4LWRQSpQ5USPxs5m+hOdCAuDkx7GzSyjU/Qma5ChlnETu86qS2L/NrxFSbUwUca4bv8q/q0uPu+eo5s2uVrqVfUu6zL+tBWc0IJwrCp93WAD9CM23BHEH686PIGOowtp/mG5vjCy+kALcXPWYc2T81LCP+EHLp6hjc6WD1bBZcpb7HhOFSu0nHWReeguZ1RDY+c3hv0SjE48DKG9sbz1PEnQpHJSaBmF7h8NTVPP5DBc9n0aUKh1nFDpslXf3MQCNbp6KAgAGaCn5PctRNf64wB8sjzoNEzfevO9qkFni6Rzaelm7VYSOIzljN42xGjpLke8qtKCzzpbzrTa9u1TRBcTPjWYys7gCJ/bR5V0kH/rIR4mboTSOchW49ZEXZJPEOLnthVnpRbqa
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3771AD32CB35064A8C40C6E485EA1A39@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f32b6b-ceb8-4333-f319-08d793722194
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 13:04:29.7637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vn7icrtT2SmJfvVMSNusAKSoGlEebPNaGQq+1jKwiZ8bMhl6h68cG3ZECfxn1L9UXI0JgdOfKjxEmrJk882YtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3120
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-07_03:2020-01-06,2020-01-07 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 07.01.20 16:33:24, Bhaskar Upadhaya wrote:
> On Mon, Jan 6, 2020 at 6:39 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Mon, Jan 06, 2020 at 04:33:19PM +0530, Bhaskar Upadhaya wrote:
> > > Definition of poll interval as per spec (referred ACPI 6.3):
> > > "Indicates the poll interval in milliseconds OSPM should use to
> > > periodically check the error source for the presence of an error
> > > condition."
> >
> > Please add that...
> >
> > > We are observing an issue in our ThunderX2 platforms wherein
> > > ghes_poll_func is not called within poll interval when timer is
> > > configured with TIMER_DEFERRABLE flag(For NO_HZ kernel) and hence we
> > > are losing the error records.
> >
> > ... and that to your commit message then, so that it is crystal clear
> > *why* you're making this change.
>=20
> Thanks Borislav, I will edit the commit message with you comments in
> the next patch.
> Can I get your Ack in the next patch ?

I guess Boris will apply the patch to his tree as maintainer, so no
need to ack it.

-Robert
