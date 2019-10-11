Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47CF5D3E97
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 13:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfJKLiU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 07:38:20 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:20660 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727198AbfJKLiU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 11 Oct 2019 07:38:20 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9BBaqNk001792;
        Fri, 11 Oct 2019 04:38:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=vjjwGzdWSmkhF/7MpqN3/pTLsXrfvwuVfvCR5zUwIF4=;
 b=lUTiZl3dor32qARB/Qy1kyoHk4NEShAKXBwN6nWg2ZcsNtdGOB0gyLUDpFThtLwrOWcE
 nX9Y6lHXylWq6W3wE7Gfcev09eYpc05J0DqkYqDLz4hR325xmjpUK4M9Cqvfs9Xgfzmw
 Khpe/EU5nq0p++a0efFoV/fMTy+pUZuG2Bxi+j2dJeSd5J7p2HR3RrIEBU6fgyt/XITm
 7r++HAQtWwdGDgGKnkduENLYRQaAZomTmkKDrCJFE6R9iJ6B9uvdQF+rTFV2o8xLRpq8
 /EI/IzmLSl2thAMdL1PLRY/bbNmGXsvalVhcYvRA8R4klxk426Dp2Y9DnmJmZbcrzpG9 GA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vjj6v1e27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 04:38:06 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 11 Oct
 2019 04:38:05 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.57) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 11 Oct 2019 04:38:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIJl8fS5L+AYHzBdqTPodEkUVlXPwL84zAnwzWj8VWV3XaBqBPrZSGvsVVz4l+LouG6yvNE5oab8SPhJa7FPs3dMIfk7GppDwXiwdws7VTEAGUoczH5djMXzVbYEXeDa4khbGsDarGdZR+aVhktG09330qftcg69Dndnd3lrZlGHwM0crhQTLRpy8FD/uVOttruvpJ6BsrjicM8441+XF0DmXELcNze6Mav9zIchQsfXQJ4x3jbvuYGFOIi3Vfozg7jirUpbHPpeI4sBhAmCFu3TX06NjOBQ+EgrzjLsFzOaLTmA+aNw83Pa7WwU51mbjpNtPW56LckE9976Pknj/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjjwGzdWSmkhF/7MpqN3/pTLsXrfvwuVfvCR5zUwIF4=;
 b=alq5nM3f6dLSJ6fbo2MI9Q6i8HfuW9rgWYOW2F68V04YLZQEMKNiReSRuJGmkJ/+YbGTGop5WGdJQzh8kl5MCeBr0fP3Vh3wVAC63qVc/YGQ1y1cwFh/NSJtcE7Ps7BPPedq4XMQqF9GsZMQic4dSYZZjVrZgblvRfcN84kbV0+gRab6pJCzBf2nNt3gUrTc0I4dTC/HkpjMOpIJSC7C4lIxSw/ZHgdCRttm2uhC2FBH6JkXYZ5+iSpWhj6yPeOZVbziBjVWB/3VYuAdQpfLZTKWfI4D8R4Pl+PCT0G5ksRKYW4ZEiQZ6AfYCfn3EPcvCiBtecwtIrMHO7OSLtQrig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjjwGzdWSmkhF/7MpqN3/pTLsXrfvwuVfvCR5zUwIF4=;
 b=FRKLGfPIBMezcJg9IkAuuodiFy5Ck7gcpTqeQ3Nbm+hs7JT9vOucD4y2E6zxtnYYxrny7tvj/gQf6tqtTnDfEkKx5v/LJUROdZIBucHUuryGj+3kY6rz1OZ2ql0iV+j8a/w+m3MW5prLMIFINyIghAbXvvQOrAk1Uwv86J2Sba0=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3088.namprd18.prod.outlook.com (20.179.21.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.25; Fri, 11 Oct 2019 11:38:03 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2347.021; Fri, 11 Oct 2019
 11:38:03 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "Jason Baron" <jbaron@akamai.com>, Tero Kristo <t-kristo@ti.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH 01/19] EDAC: Replace EDAC_DIMM_PTR() macro with
 edac_get_dimm() function
Thread-Topic: [PATCH 01/19] EDAC: Replace EDAC_DIMM_PTR() macro with
 edac_get_dimm() function
Thread-Index: AQHVf6jNve/3IMiRJ0u/d/8Li7yNM6dVNayAgAAbp4A=
Date:   Fri, 11 Oct 2019 11:38:03 +0000
Message-ID: <20191011113755.atvr5bomixquo5eu@rric.localdomain>
References: <20191010202418.25098-1-rrichter@marvell.com>
 <20191010202418.25098-2-rrichter@marvell.com>
 <20191011065857.00f287cf@coco.lan>
In-Reply-To: <20191011065857.00f287cf@coco.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0069.eurprd04.prod.outlook.com
 (2603:10a6:3:19::37) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f58198d3-a3d2-499c-776e-08d74e3f7a0b
x-ms-traffictypediagnostic: MN2PR18MB3088:
x-microsoft-antispam-prvs: <MN2PR18MB30886B1291CA39D377DBED31D9970@MN2PR18MB3088.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(189003)(199004)(52314003)(446003)(386003)(71190400001)(26005)(81166006)(53546011)(186003)(558084003)(5660300002)(52116002)(6916009)(81156014)(11346002)(478600001)(8676002)(6506007)(256004)(476003)(71200400001)(6246003)(1076003)(14454004)(25786009)(66476007)(486006)(64756008)(66556008)(66446008)(66946007)(102836004)(86362001)(76176011)(305945005)(6512007)(7736002)(9686003)(66066001)(229853002)(54906003)(4326008)(6436002)(3846002)(6116002)(99286004)(8936002)(2906002)(6486002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3088;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LU97s6tR1I7OJ1jhOJG9ypNYaK1NWaOmu2Gy99rP1WC6eIECvqUTAjId7N3y51GbviqwcDWvJIj5CUBxvuckk5vUZht2BkBIIIaey3IK6lhPH6izKeP/0ta8+AvZ6QTewYjgIXBJbVynjSr5UTphiVwDKPDbaUbFdrcS1PaXoLe+QovS4s+Cn5Ed2F8lqzx8T+TsgvOrkJuP1PxIErXO1eoVoF1ddXqE680tDilb2exY7ScV+YniprL3bjUzgngAUj9N2JODLY03eMtWW3vPfUEOkS+91ag0K1956oCIwqr1NSsKjtG5mbHsQw8sMT9NKZ70t/7z9hVkprC/6AfZf/zLSYQ8DfgMESsr5QrzQwAlBaj1VMt9y1Y0pxpQfX31IvTGWmyXIHc0+9WT4+NGRCGVzRZVoKlIPWJPCshSj9A=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B291FF1452F78A44963F2CA82C2D01B7@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f58198d3-a3d2-499c-776e-08d74e3f7a0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 11:38:03.5391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dm/zRnfrX7/KDATwwOoAr0X/Aeeio5eZpPN6hNnCH5DzpkeaT9srpJYHk+66raUWcErvo2Hp+s/rFSSi77c12Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3088
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_07:2019-10-10,2019-10-11 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 11.10.19 06:58:57, Mauro Carvalho Chehab wrote:
> Anyway, if you have a good reason to add this idx, please place
> it on a separate patch, with a proper description about why
> it is needed.

Right, see next patch. Will change.

-Robert
