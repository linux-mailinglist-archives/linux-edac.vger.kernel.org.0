Return-Path: <linux-edac+bounces-1504-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A908392F462
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2024 05:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7F61F21928
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2024 03:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA77DDBC;
	Fri, 12 Jul 2024 03:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RG/gxobT"
X-Original-To: linux-edac@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0ED9460;
	Fri, 12 Jul 2024 03:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720754889; cv=fail; b=bkdhUbhtYan44UJeSkBRkWnnoDeCXrfP3zow3M0yqK2mJHYByu5vWyig0UVn/7KV1BEokTx4cAwOPnZ1NVvskO/1sRTvoGEGySVtzCucWQ03SMq0GAMiKQOboGqLujfZNA2/55uwmkixyMYt8pNA6ijEQjpXqzgl7MF0Va5dheY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720754889; c=relaxed/simple;
	bh=41FT1nB0br7UqMD527hUbOaZCw4uFCk9Mj4lWrv1AUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jWsTZ7uPFZTM9X7aI0gk3v9DMum0G/6Psh/cfkviboBcmagC1cpGGuMtBcHDi6QfZV7NgBNv+vMmdASjqnr+zBEGgEXludy1oQKr9G02VIMKKSsa58N4xeC4hmsMfONPKqQOoC0ojrpMo8dTvfc6p0taP5FUMg8lUOvYcycV+K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RG/gxobT reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaZPxsS0v70N74GdUMPbafwmGJvdtbZ0ZZycsiQBPUysCvuQgt7zm9zi/bq4Zp+HhzV5X0Akt6gPsb0zX7WZep7igs3qMnXT36cDR7bzhmn0rrHEYo8Sa6flmSSUD3+HhcwPvnw8RcRUF/Rr2bGWOPNgctzaqM5g+M+hTfBpkZSig5GEZM+lNUa1ylYdfem+ZaqZVLFaefCKepUo2AmxdqdMEwP7GMhGl2Bya0LBpowrgtVwuTLzyUbxlva0seZ7Qjc8OCHxRS45MI0WaBeGTSmVKtnAzXWa4LeE5AsrWV1cpzivKhbdAig2JNCGydPjKgDI1C2abToqfXVeBq5CdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53IwxZJpOCJY0jba9As3b0RYDBiBxQBo3El+iMJh7fc=;
 b=eE/oNxFMMW6U46RHZ8bVPpaKaOfUO2GBFrkdTNzQyjNwt+D0Ov4PnZN0Ty2zZTZ/vvFqT1VlTurMVr34C3ejCDoBYizQNwVHNXvmu29539dz74bSYXupK74nQT1YufSy4mLx8aK0bGTgkWeNPX/emC/7eFbGFGcsxGDqhb28BVDYs99hYhNDrecZDtWK/ozPcKqh2ZV27f6FNKhnlzyDA0gghtCktVL9ZZpx4bbUhFrNWT8d/7balMehM8+y02KEp7xppcjjmldmaPd/X5HlHCbBRCXJTsLmtipAkxEX+z9uM5nNM3RUjSeF331i7a64Xcgq0VMCFSoNXgxHjvwNBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53IwxZJpOCJY0jba9As3b0RYDBiBxQBo3El+iMJh7fc=;
 b=RG/gxobTsieIPliYew5pyYSo+b+at8hnTdPLDz0+eHabLDx0I18x92Wp+aKtHiZmqBI0uPfNeFb6iUhepOZDQ+cEdRdDoEYkoEy3r0UM33x1vkjFFJGuvj/2gRC+fd2XM6MX29qupn9ucr9DnMsPNUOrgXFGDt/E/Wlll3VNRvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM7PR04MB7110.eurprd04.prod.outlook.com (2603:10a6:20b:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 03:28:04 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 03:28:04 +0000
Date: Thu, 11 Jul 2024 23:27:54 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: York Sun <york.sun@nxp.com>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 4/6] dt-bindings: memory: fsl: Add compatible string nxp,
 imx9-memory-controller
Message-ID: <ZpCiujvOKJpz6/JU@lizhi-Precision-Tower-5810>
References: <20240709-imx95_edac-v1-0-3e9c146c1b01@nxp.com>
 <20240709-imx95_edac-v1-4-3e9c146c1b01@nxp.com>
 <6068670.lOV4Wx5bFT@steina-w>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6068670.lOV4Wx5bFT@steina-w>
X-ClientProxiedBy: SJ0PR03CA0363.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::8) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM7PR04MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f41fa57-3f09-40b1-671a-08dca222a40f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?EsklIXChEUfeOCv/ReriWIQv3Hmbxws6fgbJ2DDsq6QgUPGjMfm0ReNkXh?=
 =?iso-8859-1?Q?w5nQTgXMHEUiwy7MMBAVjzETgyrbCiQmyGCNKgdw+LCadDDFTXh5pT3g/c?=
 =?iso-8859-1?Q?7J8nENVOHisGQNCwuLfTPhm7k/iwGdZkSIc0OLGmgeMaUrdETc6DY2Wl+C?=
 =?iso-8859-1?Q?/21i3Jn1QyrBvnKZ98dN0dkoC16xcXw8xg2Bv2CLizQ2WUk8PXjGmX3D2z?=
 =?iso-8859-1?Q?bsS4nGkfHe1hblg5TaEu5jxy9tfT0WKkBKjN7oviQ6HfHZ2PgjeXQWIsgB?=
 =?iso-8859-1?Q?jqsqDFDyqUA6G/MucOe7CzSEwiG3xU/3RSec4TgUf8CmeB5YJAXWIkB28L?=
 =?iso-8859-1?Q?K5Ob4YbfLKZp76k/YaBA5FHxMtv8CwBJsQ+wZQFT2EG5K351BG2SwOXLmw?=
 =?iso-8859-1?Q?i0V1HB6IhNSk96ghMizXYN/Pwn/Ml/ea/qO5fCwGmXNsDF55exXBm8ZPYZ?=
 =?iso-8859-1?Q?3bktu8YlxLlZ8oe11HwbFj1Io21zeRceu5q7zsKxlFvhd+PjkbMwJoURwo?=
 =?iso-8859-1?Q?BPChbZjKiL9985Rjp+6zcTkJUnCRV0+ZT82ru2QtNV1/ZW7zFj9jyUpguj?=
 =?iso-8859-1?Q?X1BM8b3a6iF8EWT8Vn4nOsPd3lIx3mUlJxETVnQgPuIRPBtHAWM/gnZl0F?=
 =?iso-8859-1?Q?JrRWRyNKxK+8FKtOoLJ1lMb0Q3FIKwoA02GRqkFqkNH+4wd5JQbWWlbdig?=
 =?iso-8859-1?Q?Ili/V61YToqEzf55Y3+D44fgUPC7i29SiXeGqjg1lgAbSAfTlXjSIZDSA4?=
 =?iso-8859-1?Q?rwONLqWp6WBSh2UTYOYOpqQBSV0A5gUoqnkjjSdHtXyPasALXPREvsoSum?=
 =?iso-8859-1?Q?2G3OKrPQDjQgnehwwDtUzK5qYSa960W4sFdvWVO+LDwNYPLkR+4MrM27mU?=
 =?iso-8859-1?Q?CrtJwuFaHPzY0McHR9uSms/3dFei+nUVoZQUahXvMOiCk8OiRsIWKkQ8oo?=
 =?iso-8859-1?Q?zIw6NEDYo+NFN9pw5yJDZk3i0edeYFdnzvFuWJF6i38YDg5dZO23rwGcdH?=
 =?iso-8859-1?Q?XfDACZp3zzhR1vpw/2uCj99lc9RiUTgv3AWs4RtzhH33StRLycWTU/Y/ZB?=
 =?iso-8859-1?Q?yeOWYgHY9Sf1n9rw3EFI4QjWIBIVYRNIenFPSbkpsUN/Qx5qYDmomh2qsL?=
 =?iso-8859-1?Q?gNbsJarO5DVwOyfvO2ejIbMQkrjE+ccJ0jhZiPgdOUBHoCnmMOzgvXlDQf?=
 =?iso-8859-1?Q?sBSfLyJ6cdF6w1iX3O0WqGjVKJ3l3H564/ZDrHMTXY6iKQQSfaNT0ueMZ5?=
 =?iso-8859-1?Q?OWTKryPg/C+gnxMRCmqvnOtRBdf1ek4b6tJ1aUHebYeTuaW3oYU/JEuoHB?=
 =?iso-8859-1?Q?azarjhke5aeZGIKpOg2G7n6IGxHTjdv7vP7SGBLBcCMDRbgAvEv5Komdb+?=
 =?iso-8859-1?Q?fX+1gl8O1OulxFpPQ8MHWl5HQwItPe6AK3JCCFv9MhVT/0LC0fl4c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?F7yxextsAhSI/9s9tqZ5h1AAUmw+ksQvUWWCVaY3LDHAW/ALIQratbaORk?=
 =?iso-8859-1?Q?kk9hP4DN0QLb0OwlBjjVLJ+BjM8Mmqp0vYn8/pX/1fLQB91TI/gwInf4lA?=
 =?iso-8859-1?Q?I4s/3h15aR+O/A4AaVGCm+GU1yEz1rGxTn4wostwn3XoBgjJyx6A4TPbk1?=
 =?iso-8859-1?Q?l5PDKI8r3312jXaSkBorjczixhkNNd9iVqJ/rIsWxWEDoTGOjGj9EZSYqr?=
 =?iso-8859-1?Q?DUxnYtNQdCmjdnlA3aJ5c0nbRJxRtajLu7A/YXAtXe6swZcVj9I/HuLb0y?=
 =?iso-8859-1?Q?Yu2Bl9qfxmlW5m0u1JNl0DRzVQtb1OIuZNvGTAA8hNxzN/6ei55z8B+5J6?=
 =?iso-8859-1?Q?MIsf/NwZztHqaxOskCsqrKYFD7PUGEIo8gABQ/dVjc6LWdUSD6Iq4HEaUX?=
 =?iso-8859-1?Q?RSyuSRokOtUrg4ZP2xb3hTEQDvgsmFRaa4egeeO2Z/OcdOhwVC8qavesue?=
 =?iso-8859-1?Q?H9oAGtKL3ARqOJAWFTyXCEK64fN9QsouLEi87A+5ouZm6CRANMT8vF5/bv?=
 =?iso-8859-1?Q?WE/tiVJzN63Qjk4odpr/73n0CTCa5JdYXE1WoNdXlecw/voe3LHESIJWCF?=
 =?iso-8859-1?Q?ldsKsWtfB2YZNO9N/v4V2YpTeUzD6BnOfdum+wC7mG8cPKtRtruKqB2XUP?=
 =?iso-8859-1?Q?vTIOY7xn7CJ5YZAKixhjoXh7iHIP4B/HIcNfwXVw+sWf6vvAGwYxQHhSIw?=
 =?iso-8859-1?Q?9LTthJY5wBbhO2Wdor4QyxE3NsVCautDtSnS4n5eRHilAyL399zc4XPoW+?=
 =?iso-8859-1?Q?eisrOexUO3/0oLxRovgR8MWxA5/Sru2Ld8kbaI4hzYxAlS6w0AnR7EVBRd?=
 =?iso-8859-1?Q?Go7oWxMNqdRPbCzrByL8+TGxbOepbiUtgBFgWEj0oKWus/E75G1t3Emf5I?=
 =?iso-8859-1?Q?enFp6ftt+HLuwqVTtSYyoJ8RsZGHgGueXyaCwVVfexEKCfWN0CIi5S9e7q?=
 =?iso-8859-1?Q?u4Mr2weyUw7w26tt5IQv5kbnLNf54ZUutAMvwJ+qZBvc+T64K3/aU9upZk?=
 =?iso-8859-1?Q?cB0LwDmRBrLDDGcSgEhwJREtQ/YKRwUBpP+RM/l0ohRSD6zqYmQXHGDyH1?=
 =?iso-8859-1?Q?rEq4kfqRev5ynjecSalPG1MMRskg0CX1kYD3UF3DxghBp46AcpFujT6SB3?=
 =?iso-8859-1?Q?LxL4uvo0mJMGKmdgIaHe6Ja44KVFAvPoqfmokdFbZ2QT9dV+G1FEsrJSoQ?=
 =?iso-8859-1?Q?DeBOpVuWG6cv0tStKjTMn9pdPTdJ5wd/b+SjAHcbdniq9APyAvs2Qunqys?=
 =?iso-8859-1?Q?jMfj5443Nh8PpKbm4LMi/cbDhpbE1mtil/DvSDxf6XrcPCSWhPnoxe0nbQ?=
 =?iso-8859-1?Q?QHRjelE0oyAThqENWOr+a/y/0jP+q55XOqu3/YnxB4S/KA0B/cVzyquMof?=
 =?iso-8859-1?Q?NHqFJSyJOpLCDSSBAAhSTmev2e+kv9x9yFIw9mrgXxiClPmxvr6+2t2GHo?=
 =?iso-8859-1?Q?77I0Fpw1lbVu3JxbNfsx8y4s80A0AwoDFPlNwj31lds9ahSdP7yDZepNvu?=
 =?iso-8859-1?Q?Iu+t0wvsSy8oxJdg416e5jmmPOX3LOjTg8P5Mg7jpGhxU9HUhzwhjWjyuI?=
 =?iso-8859-1?Q?82tFZo4utOSnlPiQEydBUdPgiZ4wjdRWdQQ3pKXl3ExrYHqIWVkpNHZMGQ?=
 =?iso-8859-1?Q?xmAviLgIj+GYEBHOdLJWyv5jbsJsx+edNs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f41fa57-3f09-40b1-671a-08dca222a40f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 03:28:04.6392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeIn6PxuZZ4pRIFkFXmI7HhSFchWhENwJ9Pn9n11nuMRmDsUXTQbta4tU70osTJqElO8CSdqNzicSinPbPfbSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7110

On Wed, Jul 10, 2024 at 09:18:16AM +0200, Alexander Stein wrote:
> Hi Frank,
> 
> Am Dienstag, 9. Juli 2024, 22:23:05 CEST schrieb Frank Li:
> > iMX9 memory controller is similar with other layerscape chips. But some
> > register layout has a little bit difference, so add new compatible string
> > 'nxp,imx9-memory-controller' for it.
> 
> Is this controller the same for all i.MX9 SoC? E.g. i.MX91, i.MX93,
> i.MX95 and any future variants?

So far it is the same. I can't prodicting future. Not plan to change it
yet.

Frank 

> 
> Best regards,
> Alexander
> 
> > imx9 need two 'reg', one for DDR controller and the other is ECC inject
> > engine register space. Keep the same restriction for other compatible
> > string.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../bindings/memory-controllers/fsl/fsl,ddr.yaml   | 31 +++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ddr.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ddr.yaml
> > index 84f778a99546b..e0786153eec73 100644
> > --- a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ddr.yaml
> > +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ddr.yaml
> > @@ -40,6 +40,7 @@ properties:
> >            - fsl,p1021-memory-controller
> >            - fsl,p2020-memory-controller
> >            - fsl,qoriq-memory-controller
> > +          - nxp,imx9-memory-controller
> >  
> >    interrupts:
> >      maxItems: 1
> > @@ -51,13 +52,41 @@ properties:
> >      type: boolean
> >  
> >    reg:
> > -    maxItems: 1
> > +    items:
> > +      - description: Controller register space
> > +      - description: Inject register space
> > +    minItems: 1
> > +
> > +  reg-names:
> > +    items:
> > +      - const: ctrl
> > +      - const: inject
> > +    minItems: 1
> >  
> >  required:
> >    - compatible
> >    - interrupts
> >    - reg
> >  
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - nxp,imx9-memory-controller
> > +    then:
> > +      properties:
> > +        reg:
> > +          minItems: 2
> > +        reg-names:
> > +          minItems: 2
> > +    else:
> > +      properties:
> > +        reg:
> > +          maxItems: 1
> > +        reg-names: false
> > +
> >  additionalProperties: false
> >  
> >  examples:
> > 
> > 
> 
> 
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
> 
> 

