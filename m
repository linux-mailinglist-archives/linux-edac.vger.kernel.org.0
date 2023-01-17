Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A3366E762
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jan 2023 21:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjAQUFB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Jan 2023 15:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjAQUC0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 17 Jan 2023 15:02:26 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A15246D5C
        for <linux-edac@vger.kernel.org>; Tue, 17 Jan 2023 10:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673981646; x=1705517646;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P6iG/tFuhZvGIY2FyAWWTIZ7pFo5Apn7lyaMGrh0CPM=;
  b=mu1MYPVJcPlR8IV9Eq+erS4yf1agjBrNY/p28UpXt7JlckXCLc55TJLx
   bA9zX8Y4IiNcperTYVtw9/BQNYIiLhSuHa6GW74eTflpaJzk13ydcIui4
   TkcfUnBqU5iqvqXbVYPk2kkRw36pcZCPKKV/xKIL0C9RDxP4SbXSnS58y
   Lek/0CrovSbDWN/hCRNcEIMN+/F+lh1XdzlfYOeD4qbn8Z6uk299tdnKQ
   0/MC/p/4dtCX8F2GxNUL8j4ZuYnnZln0sgrn7yTYZlRBpew6aSajxZ9MI
   aMDWCJe9jUonq1PRQDfS0b3xwc9U5CLviuqp4NGt43Y4ssQaXlNcJx0xa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="312656822"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="312656822"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 10:54:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="652634729"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="652634729"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 17 Jan 2023 10:54:04 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 10:54:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 10:54:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 10:54:03 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 10:54:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2CUXbVFW7vd2oIRnerVm6extbqIdtCIRo30wgRKZ8g8SpKTdB43TWUU7MMnQ4QkMcCeiVq8f0dzRj23/MY/Z5PhK/Zw4nsvpcYgl90IjXIbTq3h3bx6u9zysUDA0NMfsa2aiKQ9ZVuZ1hlT+2ujh7QAJvN45BrHSpPy1WX8fNr/eTrCeSmm+0L4JUCmKVhmVVmNzlhvK1zqcfI7UgBDWax2vbGt6pN4rgPFymIA/LwJX+Kx7qA81hfu/ODsCsSCfSCpQC6f8A6rDT2vDjSY4P1tRzYhBZwWGcLyIATyGG8NALLzMEqTyV2S+X9gz1QAHeWByjW58+0+yrB5Tk5rUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6iG/tFuhZvGIY2FyAWWTIZ7pFo5Apn7lyaMGrh0CPM=;
 b=TwlN7/Kd0ihmPcfTZmY8aeW+hVqOREyH6Q/ndJznr1CVJVOlzA+Jn1wON5H/pwdNOrgyCEMcc8oFo7LneAMF5TE2HsoZmO+r/yP4UtxoR4xKvQvQlwotfaDRF7rcpDIs5uSIPMXGj7ak8CkbdONfUVKfN3QvZuL7x2MMx0tKq8qgpCG32Inyrou4+7bzpU5LYIYofabi4QokrKDBr88F9pUESoS/MSBn8dQXUyCkkn1hxL/tCE2N7m/HNtTfsEcTbhL3LdbTjEw4A8Wcdx0WikPWXlbxL4edY3+JXwAJIB3aUnm3S9CVEzkefeowOTROsmL5C9LUL47F0ZDVRyQSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6076.namprd11.prod.outlook.com (2603:10b6:208:3d4::11)
 by DM4PR11MB8227.namprd11.prod.outlook.com (2603:10b6:8:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Tue, 17 Jan
 2023 18:54:02 +0000
Received: from IA1PR11MB6076.namprd11.prod.outlook.com
 ([fe80::7e0e:8bf8:b12d:fcab]) by IA1PR11MB6076.namprd11.prod.outlook.com
 ([fe80::7e0e:8bf8:b12d:fcab%8]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 18:54:02 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aristeu Rozanski <aris@ruivo.org>
CC:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "aris@redhat.com" <aris@redhat.com>
Subject: RE: [RFC PATCH] mce: prevent concurrent polling of MCE events
Thread-Topic: [RFC PATCH] mce: prevent concurrent polling of MCE events
Thread-Index: AQHZKeVgS+RUxFZo/k2Cv7a8Veq3q66i4AIggAATkgCAAAIosA==
Date:   Tue, 17 Jan 2023 18:54:02 +0000
Message-ID: <IA1PR11MB607672430721985FD208F00BFCC69@IA1PR11MB6076.namprd11.prod.outlook.com>
References: <Y8WtE7BNJ0gTrqIS@cathedrallabs.org>
 <SJ1PR11MB6083410C8464DEC926C0BDB9FCC69@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y8bsejfSuXZ/NaEu@cathedrallabs.org>
In-Reply-To: <Y8bsejfSuXZ/NaEu@cathedrallabs.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6076:EE_|DM4PR11MB8227:EE_
x-ms-office365-filtering-correlation-id: 6724fe18-f416-4afd-0e8e-08daf8bc334f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: udJpUpjyERHP1xivrE7VHOS1FGMYW6VMY+RxVRNa2qQCYQWM2f8K84u6pkuIRzzK06b0stSAtEgDMyIpLeF5k9zQ6zR5CE535HJ5FbugYVfdRkMyF2z+7gMf27MExKapAbut8YjxF0mHmJIEU5DcIc4Bcymyb1SlxIcsV3bEeMiucUEx2HHXs/XtlFWFixWfEe9nutRHqqR9I307XYEk01Mgkqae2l8IREinhfaVxDUYmjh2u96/K23XYJfT1fzQqtsZfCHqKXkTJYHi7wd3iqn/9l0mT9+AIa3G3e8a4t8tEUK5kY0nFHdMhJALE/zufFfQjTA5N/t8BVZ2NsU0ePNkncy5AkKJ9w8eX2UZX+bm+OAnd9V/+cIqVCV3hBqMh3pF31wTitr+WuybOnnF6vSVPJefAwKqmRF6f+0JQr/4EvXo2Znyej+DSvfXlx1mefzDWb4s3+UBZK0zYPIYTC0dHUSWZqs4rCNGQ+raqLBZU3Y+fKA7fUZRI0ok5l9++I8S15yjglfznCAD18cUw+RBHwYP5nMq/90SjEjsARQpIMtfH2cfWNbJcZCyawT990e/9PEWBzvGze4nmc1MpRb9ZnHBhhMOt21v84bIFLs3zSe3TwqG/DfI7MA1RQv7YQqkGY0VQ+nJgxKwNE9H+keNdwZu46vxBH3fyOslPlV9JME4ZHKfjO8/tbc7TEnonOQC1HMWOTLJ4mTKJgmmXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6076.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199015)(6506007)(82960400001)(122000001)(33656002)(2906002)(38100700002)(316002)(4744005)(9686003)(7696005)(478600001)(8936002)(38070700005)(66476007)(52536014)(4326008)(66946007)(66446008)(86362001)(64756008)(66556008)(76116006)(55016003)(83380400001)(26005)(186003)(54906003)(8676002)(5660300002)(41300700001)(71200400001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cgP4t9471ouqbDwFXN+gAPPCNYgKNI4KbJX8aiGze1jJPPGywKe4WnvcdiW4?=
 =?us-ascii?Q?sVPmktZyyDUo+md5njKge7DN5bTOpUVS9qVSniXiM3n6ILER4dFaqA5xt7Vs?=
 =?us-ascii?Q?xj/PoIchgVv5HA28Kg4ys+/aJwHAGTpRfsz3ZLW5NEmV5J29NLTUpmpTcZhf?=
 =?us-ascii?Q?6OoY4vLUXzH0gttXq9hcfIKj3XLrbP2mQWs1HixPVlejRvem1MhbNch1HnJ0?=
 =?us-ascii?Q?44tyEAvlFgeVzRBqzBMyv03zLbRHvwSIpiozRFY9QsvgsPdhcyu+thJdlVY0?=
 =?us-ascii?Q?SUB9II/Oyjuw4uq/jzSPAeksJkX+wNTwJp4Hrxp4o4Meq6pivaVC33+1w//V?=
 =?us-ascii?Q?DaRhZyTiwCx0U3tdlPuahu9vUMAJmOXh2G0sXtQ+pTuG5ZjsLhmZU9+Ar9ii?=
 =?us-ascii?Q?j2trJMIidoVHByUU9rnK5r8+mxNPuTIYcOqpX/j8G3pfcCyW6vx+FaeyguJ0?=
 =?us-ascii?Q?G1c+LsjlEu+7cbSf0+qj3iHAXmA9CUDJFxBefUGauZlhJxjrZRU/SAU7q/3W?=
 =?us-ascii?Q?cDN2d3msYxznx8hjAYBgeQPFrNJz70KkP6OT3fAl9Cxu7g7UpasicMzI4yNa?=
 =?us-ascii?Q?Fn1ob/haBVjREHJY/ovruVXY+YkAM5/PH9RWI0+eXJ9LM2u7wYUCJmXaKMF+?=
 =?us-ascii?Q?SBU6wtqopY+fb6fB5ZYEukzQdQmGbT2bGOMuk5W0ItYav9onzJhSGT/YXWpF?=
 =?us-ascii?Q?EmrFxkZzfLrqO3M2gMoDHYSeCj/leKEvE4C9fU8NjXplkuajbPVeHDt+dfsJ?=
 =?us-ascii?Q?Cipul3U9/3UqDZbnl01bDd+9rRKplhWb+dhE8JRsRSyGTjr8+AwKWncpMHJp?=
 =?us-ascii?Q?Tb8UIDs8jtfKE+M6EG5NMJ59bizH8lO0JCapqjGXV9z6x/0x0Sb741rBwjVp?=
 =?us-ascii?Q?5b4SNZX2r6Wvz0NbOChDrT9Mh4pggnMqyFn8E47M5XMo0j3/onodgG//L7ml?=
 =?us-ascii?Q?QTP+Peg7qwiT1K2EsneZ5vuhQK9xoQePlBkioINVdujR/PMlEG7jWOYgqCx2?=
 =?us-ascii?Q?NaLxhb+gDOtmsdB61hf3z+2L4rTIC5DfdIpExEUJYI5co//hzhBHSIOPg7Sn?=
 =?us-ascii?Q?+B//oteYjX1NGBUGS6o35Sx5THcnNi4esfXXyWCm0F/o4ifysQcQlFUMeVvC?=
 =?us-ascii?Q?i9UXgUzFw+qfhz/rivKkVNqcEnJk3zkv9YapLqr1papHj/qKwpEY/zM2uWqp?=
 =?us-ascii?Q?45Ps1pqivhizAgycTvBGfZj6x+AVkWN/Y8WlZ8uKwBhRViIXjyMcxndo3QnH?=
 =?us-ascii?Q?OscmC8Cxam15W+ZdBj2h1BB4z9SjOo3h9ICxquHcGCtysr2SaIhhX3J8OnK7?=
 =?us-ascii?Q?8RUkrKeU0isap/IRY0MJ0Ja67I+8uv0dIMxCpPEh0Eh41mE8fxh93DOzzLdN?=
 =?us-ascii?Q?Vr+6if2RyoUSe4+o6Go3SXQfDCPYLz+0NmxtvZGwNMhZoVLgn1xxHpvUyVOY?=
 =?us-ascii?Q?dU0F2TYD7e3OKeP1ojeh0WMkf/kj57fPWkm7QnoTFSs98IE7qq1SAH105x/d?=
 =?us-ascii?Q?3jhBrVcyl/uDgRPiPQ2tAYxj/2ULYYsXpDwNjjLToKO/I7qzuxfrVtz4rMQo?=
 =?us-ascii?Q?aye8bMkkx/Gi87UIzrY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6076.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6724fe18-f416-4afd-0e8e-08daf8bc334f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 18:54:02.4393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VRiRHTn7xi7Y9mOy5VIc9bfXQ6FTeF89GJBLs48Ngz1myj1y3luZ2/c0UgoQXcC/S9njB+ncgrxCr6aP6zW72g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8227
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> Yes, but could change the patch to include mce_available() into the
> protection of the lock. It should cleared once machine_check_poll() clear=
s
> the bank state, no?

Which machines are showing this problem? Most modern systems support
CMCI. So I'm thinking that this case shows up because the sysadmin booted
with "mce=3Dno_cmc;". In that case I don't think mce_available() check woul=
d
change anything.

-Tony
